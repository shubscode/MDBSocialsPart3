//
//  ViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var titleLabel: UILabel!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var email: String!
    var password: String!
    
    var signUpLabel: UILabel!
    var signUpButton: UIButton!
    
    var loginButton: UIButton!
    
    var mdbLogo: UIImageView!
    
    var correctPassword = false
    var backgroundColours = [UIImage()]
    var backgroundLoop = 0
    
    var backgroundImage: UIImageView!
    
    var customBlue = UIColor(hue: 0.5472, saturation: 0.75, brightness: 0.94, alpha: 1.0)
    var customWhite = UIColor(hue: 0.5972, saturation: 0.24, brightness: 0.95, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createBackground()
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toFeedView", sender: self)
        }
    }
    
//    func setBackground() {
//
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = #imageLiteral(resourceName: "starSky")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
//    }
    //Create background
    func createBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.backgroundColor = Constants.loginColor
        view.addSubview(backgroundImage)
    }
    func setup() {
        
        mdbLogo = UIImageView(frame: CGRect(x: view.frame.midX - 85, y: 10, width: 170, height: 300))
        mdbLogo.contentMode = .scaleAspectFit
        mdbLogo.image = #imageLiteral(resourceName: "mdbLogo")
        view.addSubview(mdbLogo)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 50))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(60)
        titleLabel.textColor = Constants.textColor
        titleLabel.textAlignment = .center
        titleLabel.text = "MDB Socials"
        view.addSubview(titleLabel)
        
        emailTextField = UITextField(frame: CGRect(x: 20, y: 370, width: view.frame.width - 40, height: 50))
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.clipsToBounds = true
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 430, width: view.frame.width - 40, height: 50))
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clipsToBounds = true
        view.addSubview(passwordTextField)
        
        signUpLabel = UILabel(frame: CGRect(x: 20, y: 570, width: view.frame.width - 40, height: 50))
        signUpLabel.text = "Don't have an account yet?"
        signUpLabel.textColor = Constants.textColor
        signUpLabel.textAlignment = .center
        view.addSubview(signUpLabel)
        
        signUpButton = UIButton(frame: CGRect(x: 20, y: 620, width: view.frame.width - 40, height: 50))
        signUpButton.backgroundColor = customBlue
        signUpButton.layer.cornerRadius = 15
        signUpButton.setTitle("SIGN UP", for: .normal)
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(toSignUpScreen), for: .touchUpInside)
        
        loginButton = UIButton(frame: CGRect(x: 20, y: 510, width: view.frame.width - 40, height: 50))
        loginButton.backgroundColor = customBlue
        loginButton.layer.cornerRadius = 15
        loginButton.setTitle("LOGIN", for: .normal)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(toFeedView), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
    }
    
    func readInputs() {
        
        if let emailResp = emailTextField.text {
            if emailResp == "" {
                print("Hello")
                raiseInvalidInfoAlert(info: "Email")
            }
            else {
                email = emailResp
                print("HI")
                print(email)
            }
        }
        if let passwordResp = passwordTextField.text {
            if passwordResp == "" {
                raiseInvalidInfoAlert(info: "Password")
            }
            else {
                password = passwordResp
            }
        }
        
    }
    func raiseInvalidInfoAlert(info: String) {
        let alert = UIAlertController(title: "Missing \(info)", message: "Please enter your \(info)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func raiseIncorrectPassword() {
        let alert = UIAlertController(title: "Invalid Password", message: "Please double check your password", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func toSignUpScreen() {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    @objc func toFeedView() {
        readInputs()
        if email != nil && password != nil {
            print("i better print this")
            UserAuthHelper.logIn(email: email, password: password, withBlock: {
                self.performSegue(withIdentifier: "toFeedView", sender: self)
               
            }, withBlock2: {self.raiseIncorrectPassword()})
        }
        
    }
    

    


}

