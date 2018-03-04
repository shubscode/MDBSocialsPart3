//
//  NewSocialViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import CoreLocation
import LocationPicker
import MKSpinner

class NewSocialViewController: UIViewController, UITextViewDelegate {

    var titleLabel: UILabel!
    var eventNameTextField: UITextField!
    var dateOfEventTextField: UITextField!
    var eventDescriptionTextView: UITextView!
    
    var eventName: String!
    var eventDate: String!
    var eventDescription: String!
    var imagePicked: UIImageView!
    
    var selectLocationButton: UIButton!
    var selectedLocation: CLLocationCoordinate2D!
    
    var image = #imageLiteral(resourceName: "startingImage")
    
    var createEventButton: UIButton!
    var addPhotoButton: UIButton!
    
    var datePicker: UIDatePicker!
    let dateFormatter: DateFormatter = DateFormatter()
    
    var customBlue = UIColor(hue: 0.5472, saturation: 0.75, brightness: 0.94, alpha: 1.0)
    var customWhite = UIColor(hue: 0.5972, saturation: 0.24, brightness: 0.95, alpha: 1.0)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set date format
        
        setup()
        
        let b = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelClicked))
        self.navigationItem.setLeftBarButtonItems([b], animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func CancelClicked(sender: UIBarButtonItem) {
       self.dismiss(animated: true, completion: {})
    }
    
    func setup() {
        titleLabel = UILabel(frame: CGRect(x: 20, y: 60, width: view.frame.width - 40, height: 60))
        //titleLabel.font = UIFont.systemFont(ofSize: 34, weight: 3)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = titleLabel.font.withSize(50)
        titleLabel.textAlignment = .center
        titleLabel.text = "Event Details"
        titleLabel.textColor = customWhite
        view.addSubview(titleLabel)
        
        eventNameTextField = UITextField(frame: CGRect(x: 20, y: 120, width: view.frame.width - 40, height: 50))
        eventNameTextField.placeholder = "Event Name"
        eventNameTextField.borderStyle = .roundedRect
        eventNameTextField.clipsToBounds = true
        view.addSubview(eventNameTextField)
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 20, y: 290, width: view.frame.width - 40, height: 120)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = customWhite
        
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
         self.view.addSubview(datePicker)
        
//        dateOfEventTextField = UITextField(frame: CGRect(x: 20, y: 340, width: view.frame.width - 40, height: 50))
//        dateOfEventTextField.placeholder = "Date of Event"
//        dateOfEventTextField.borderStyle = .roundedRect
//        dateOfEventTextField.clipsToBounds = true
//        view.addSubview(dateOfEventTextField)
        
        eventDescriptionTextView = UITextView(frame: CGRect(x: 20, y: 180, width: view.frame.width - 40, height: 80))
        eventDescriptionTextView.delegate = self
        eventDescriptionTextView.layer.borderColor = UIColor.gray.cgColor
        eventDescriptionTextView.layer.borderWidth = 0.5
        eventDescriptionTextView.text = "Add event description here"
        eventDescriptionTextView.textColor = UIColor.lightGray
        //eventDescriptionTextView.place = "Add event description here"
        //eventDescriptionTextView.borderStyle = .roundedRect
        eventDescriptionTextView.clipsToBounds = true
        view.addSubview(eventDescriptionTextView)
        
        imagePicked = UIImageView(frame: CGRect(x: 20, y: 420, width: 130, height: 130))
        imagePicked.image = image
        imagePicked.contentMode = .scaleAspectFill
        imagePicked.clipsToBounds = true
        imagePicked.layer.cornerRadius = 10
        view.addSubview(imagePicked)
        
        selectLocationButton = UIButton(frame: CGRect(x: view.frame.midX, y: 420, width: 130, height: 130))
        selectLocationButton.setTitle("Select Location", for: .normal)
        selectLocationButton.layer.cornerRadius = 10
        selectLocationButton.backgroundColor = UIColor.flatSkyBlue
        selectLocationButton.setTitleColor(Constants.textColor, for: .normal)
        selectLocationButton.addTarget(self, action: #selector(selectLocation), for: .touchUpInside)
        view.addSubview(selectLocationButton)
        
        addPhotoButton = UIButton(frame: CGRect(x: 20, y: 570, width: view.frame.width - 40, height: 40))
        addPhotoButton.backgroundColor = customBlue
        addPhotoButton.layer.cornerRadius = 15
        addPhotoButton.setTitle("Add Photo", for: .normal)
        addPhotoButton.addTarget(self, action: #selector(toImagePicker), for: .touchUpInside)
        view.addSubview(addPhotoButton)
        
        
        createEventButton = UIButton(frame: CGRect(x: 20, y: 620, width: view.frame.width - 40, height: 40))
        createEventButton.backgroundColor = customBlue
        createEventButton.layer.cornerRadius = 15
        createEventButton.setTitle("CREATE EVENT", for: .normal)
        view.addSubview(createEventButton)
        createEventButton.addTarget(self, action: #selector(returnToFeed), for: .touchUpInside)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        nullCheck()
        view.addGestureRecognizer(tap)
        setBackground()
    }
    func setBackground() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "starsky2")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc func selectLocation() {
        let locationPicker = LocationPickerViewController()
        
//        let location = CLLocation(latitude: 37.8719, longitude: 122.2585)
//        let initialLocation = Location(name: "UC Berkeley", location: location, placemark: CLPlacemark() )
//        locationPicker.location = initialLocation
//
        locationPicker.showCurrentLocationButton = true
        locationPicker.currentLocationButtonBackground = Constants.loginColor!
        locationPicker.showCurrentLocationInitially = true
        locationPicker.mapType = .standard
        locationPicker.useCurrentLocationAsHint = true
        locationPicker.resultRegionDistance = 500
        locationPicker.completion = { location in
            self.selectedLocation = location?.coordinate
        }
        
        self.present(locationPicker, animated: true) {
            print("Selecting location")
        }
    }
    
    func nullCheck() {
        print(eventName)
        print(eventDate)
        if eventName != nil && eventDate != nil {
            eventNameTextField.text = eventName
            eventDescriptionTextView.text = eventDescription
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = dateFormatter.date(from: eventDate)
            
            datePicker.date = date!
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add event description here"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Apply date format
        eventDate = dateFormatter.string(from: sender.date)
        
        print("Selected value \(eventDate)")
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func readEventInfo() {
        let event = eventNameTextField.text
        let date = eventDate
        let desc = eventDescriptionTextView.text
        if event == "" {
            raiseInvalidInfoAlert(info: "Event Name")
        }
        else if date == "" {
            raiseInvalidInfoAlert(info: "Event Date")
        }
        else {
            eventName = event
            //eventDate = date
            eventDescription = desc
        }
        
    }
    func raiseInvalidInfoAlert(info: String) {
        let alert = UIAlertController(title: "Missing \(info)", message: "You must provide an \(info)!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImagePicker" {
            if let destinationVC = segue.destination as? ImagePickerViewController {
                print("help2")
                destinationVC.eventName = self.eventName
                destinationVC.eventDate = self.eventDate
                destinationVC.eventDescription = self.eventDescription
                print("help3")
            }
        }
    }
    
    @objc func toImagePicker() {
        readEventInfo()
        self.performSegue(withIdentifier: "toImagePicker", sender: self)
    }
    
    @objc func returnToFeed() {
        readEventInfo()
        if selectedLocation == nil {
            raiseInvalidInfoAlert(info: "Location")
        } else {
            MKFullSpinner.show("Creating Event", animated: true)
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            print(userID)
            ref.child("Users").child(userID!).child("name").observeSingleEvent(of: .value, with: {(snapshot) in
            let name = snapshot.value
            let user = name! as? String
            print("USER IS \(user)")

            
                FirebaseAPIClient.createPost(selectedImage: self.imagePicked.image!, posterName: user!, name: self.eventName, description: self.eventDescription, dateString: self.eventDate, location: self.selectedLocation).then { success -> Void in
                MKFullSpinner.hide()
                self.dismiss(animated: true, completion: {
                    print("Post Complete")
                })
            }
            })
        }
    }
//        let ref = Database.database().reference()
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        let eventImageData = UIImageJPEGRepresentation(imagePicked.image!, 0.9)
//        let userID = Auth.auth().currentUser?.uid
//        print(userID)
//            ref.child("Users").child(userID!).child("name").observeSingleEvent(of: .value, with: {(snapshot) in
//            let name = snapshot.value
//            let user = name! as? String
//            print("USER IS \(user)")
//            let newPost = ["name" : self.eventName, "text": self.eventDescription, "date": self.eventDate, "poster": user,"interested": [""]] as [AnyHashable : Any]
//            let postRef = Database.database().reference().child("Posts")
//            let key = postRef.childByAutoId().key
//            let update = ["/\(key)/" : newPost]
//            //print("GOT TO HEREEEE AGAIN")
//            let storageRef = Storage.storage().reference().child("Posts").child(key)
//            storageRef.putData(eventImageData!, metadata: metadata, completion: { (metadata, error) in
//                if error != nil {
//                    print(error)
//                } else {
//                    postRef.updateChildValues(update)
//                    self.dismiss(animated: true)
//                }
//            })
//            
//            
//        })
        
        

    }



