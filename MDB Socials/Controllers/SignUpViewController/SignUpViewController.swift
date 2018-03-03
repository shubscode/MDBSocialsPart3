//
//  SignUpViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    var titleLabel: UILabel!
    
    
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    
    var username: String!
    var password: String!
    var name: String!
    var email: String!
    
    var signUpLabel: UILabel!
    var signUpButton: UIButton!
    
    var loginButton: UIButton!
    
    var ref: DatabaseReference!
    
    var customBlue = UIColor(hue: 0.5472, saturation: 0.75, brightness: 0.94, alpha: 1.0)
    var customWhite = UIColor(hue: 0.5972, saturation: 0.24, brightness: 0.95, alpha: 1.0)
    
    var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBackground()
        ref = Database.database().reference()
        
        setup()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    
    func setup() {
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 100))
        //titleLabel.font = UIFont.systemFont(ofSize: 34, weight: 3)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(90)
        titleLabel.textColor = Constants.textColor
        titleLabel.textAlignment = .center
        titleLabel.text = "Sign Up"
        view.addSubview(titleLabel)
        
        nameTextField = UITextField(frame: CGRect(x: 20, y: 220, width: view.frame.width - 40, height: 50))
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.clipsToBounds = true
        view.addSubview(nameTextField)
        
        emailTextField = UITextField(frame: CGRect(x: 20, y: 280, width: view.frame.width - 40, height: 50))
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.clipsToBounds = true
        view.addSubview(emailTextField)
        
        usernameTextField = UITextField(frame: CGRect(x: 20, y: 340, width: view.frame.width - 40, height: 50))
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.clipsToBounds = true
        view.addSubview(usernameTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 400, width: view.frame.width - 40, height: 50))
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clipsToBounds = true
        view.addSubview(passwordTextField)
        
        
        signUpLabel = UILabel(frame: CGRect(x: 20, y: 520, width: view.frame.width - 40, height: 50))
        signUpLabel.text = "Already have an account?"
        signUpLabel.textColor = Constants.textColor
        signUpLabel.textAlignment = .center
        view.addSubview(signUpLabel)
        
        signUpButton = UIButton(frame: CGRect(x: 20, y: 570, width: view.frame.width - 40, height: 50))
        signUpButton.backgroundColor = customBlue
        signUpButton.layer.cornerRadius = 15
        signUpButton.setTitle("SIGN IN", for: .normal)
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(toSignInScreen), for: .touchUpInside)
        
        loginButton = UIButton(frame: CGRect(x: 20, y: 460, width: view.frame.width - 40, height: 50))
        loginButton.backgroundColor = customBlue
        loginButton.layer.cornerRadius = 15
        loginButton.setTitle("CREATE USER", for: .normal)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(toFeedView), for: .touchUpInside)
    }
    
    func readInputs() {
        let nameResp = nameTextField.text
        let usernameResp = usernameTextField.text
        let emailResp = emailTextField.text
        let passwordResp = passwordTextField.text
        if nameResp == "" || usernameResp == "" || emailResp == "" || passwordResp == "" {
            raiseInvalidInfoAlert();
        } else {
            name = nameResp
            username = usernameResp
            email = emailResp
            password = passwordResp
        }
        
    }
    func raiseInvalidInfoAlert() {
        let alert = UIAlertController(title: "Invalid Information", message: "Please fill out all text fields", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func toSignInScreen() {
        self.dismiss(animated: true, completion: {})
    }
//    func setBackground() {
//        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = #imageLiteral(resourceName: "starSky")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
//    }
    func createBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.backgroundColor = Constants.loginColor
        view.addSubview(backgroundImage)
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @objc func toFeedView() {
        readInputs()
        
        UserAuthHelper.createUser(email: email, password: password, withBlock: { (uid: String) in
            FirebaseAPIClient.createNewUser(id: uid, name: self.name, email: self.email)
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.nameTextField.text = ""
            self.performSegue(withIdentifier: "toFeedView", sender: self)
        })
        //self.dismiss(animated: true, completion: {})
        //self.performSegue(withIdentifier: "toFeedView", sender: self)
        
    }
}
