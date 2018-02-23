//
//  ImagePickerViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/20/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import MKSpinner

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var imagePicked: UIImageView!
    var fromLibraryButton: UIButton!
    var fromCameraButton: UIButton!
    var confirmButton: UIButton!
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    var currentImage = #imageLiteral(resourceName: "startingImage")
    var chosenImage: UIImage!
    
    var eventName: String!
    var eventDate: String!
    var eventDescription: String!
    
    
    //var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setBackground()
//        let lightBlue = UIColor(hue: 0.5667, saturation: 0.58, brightness: 0.96, alpha: 1.0)
//        let midBlue = UIColor(hue: 0.5667, saturation: 0.72, brightness: 0.96, alpha: 1.0)
//        let darkBlue = UIColor(hue: 0.5667, saturation: 0.82, brightness: 0.96, alpha: 1.0)
//        backgroundColours = [lightBlue, midBlue, darkBlue]
//        backgroundLoop = 0
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        imagePicked = UIImageView(frame: CGRect(x: 0, y:20, width: view.frame.width, height: view.frame.midY + 30))
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        imagePicked = UIImageView(frame: CGRect(x: 0, y:20, width: view.frame.width, height: view.frame.midY + 30))
//        imagePicked.contentMode = .scaleAspectFit
//        imagePicked.image = currentImage
//        imagePicked.layer.borderColor = UIColor.black.cgColor
//        view.addSubview(imagePicked)
//    }
    func setup() {
        imagePicked = UIImageView(frame: CGRect(x: 20, y:50, width: view.frame.width - 40, height: view.frame.width))
        imagePicked.image = #imageLiteral(resourceName: "startingImage")
        imagePicked.contentMode = .scaleAspectFit
        //print("STARTING IMAGE")
        //print(imagePicked.image)
        imagePicked.layer.borderColor = UIColor.black.cgColor
        view.addSubview(imagePicked)
        
        fromLibraryButton = UIButton(frame: CGRect(x: 20, y: view.frame.width + 60, width: view.frame.width - 40, height: 40))
        fromLibraryButton.backgroundColor = UIColor.blue
        fromLibraryButton.layer.cornerRadius = 15
        fromLibraryButton.setTitle("Select From Camera Roll", for: .normal)
        fromLibraryButton.addTarget(self, action: #selector(selectFromCameraRoll), for: .touchUpInside)
        view.addSubview(fromLibraryButton)
        
        fromCameraButton = UIButton(frame: CGRect(x: 20, y: view.frame.width + 110, width: view.frame.width - 40, height: 40))
        fromCameraButton.backgroundColor = UIColor.blue
        fromCameraButton.layer.cornerRadius = 15
        fromCameraButton.setTitle("Take A Photo", for: .normal)
        fromCameraButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        view.addSubview(fromCameraButton)
        
        confirmButton = UIButton(frame: CGRect(x: 60, y: view.frame.width + 170, width: view.frame.width - 120, height: 40))
        confirmButton.backgroundColor = UIColor.blue
        confirmButton.layer.cornerRadius = 15
        confirmButton.setTitle("Confirm Selection", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmImageSelection), for: .touchUpInside)
        view.addSubview(confirmButton)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pictureSelected" {
            print("ENTERED THIS LOOP")
            if let destinationVC = segue.destination as? NewSocialViewController {
                destinationVC.imagePicked = self.imagePicked
                if chosenImage == nil {
                    chosenImage = currentImage
                }
                destinationVC.image = chosenImage
                destinationVC.eventName = self.eventName
                destinationVC.eventDate = self.eventDate
                destinationVC.eventDescription = self.eventDescription
            }
        }
    }
    
    @objc func confirmImageSelection() {
        self.performSegue(withIdentifier: "pictureSelected", sender: self)
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //MKFullSpinner.show("Selecting Image...", animated: true)
        imagePicked.contentMode = .scaleAspectFit
        imagePicked.image = chosenImage

        dismiss(animated:true, completion: nil)
    }
    
    @objc func selectFromCameraRoll() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setBackground() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "starsky5")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    

   
}


