//
//  NewEntryViewController.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/7/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var imagePickerController = UIImagePickerController()

    
    var trip: Trip?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
        //dateTextField.delegate = self
        detailsTextField.delegate = self
        
        
        if let entry = self.entry{
            titleTextField.text = entry.title
            detailsTextField.text = entry.details
            datePicker.date = entry.rawDate! as Date
            imageView.image = UIImage(data: entry.rawImage as! Data)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
        //dateTextField.resignFirstResponder()
    }
    
    
    @IBAction func saveEntry(_ sender: Any) {
        let title = titleTextField.text ?? ""
        //let date = dateTextField.text
        let date = datePicker.date
        let details = detailsTextField.text ?? ""
        let image = imageView.image
        
        
//        if let imageData = Entry?.rawImage as Data? {
//            let myImage = UIImage(data: imageData)!
//        }
        
        if let data = image?.pngData(), let entry = Entry(title: title, rawDate: date, details: details, rawImage: NSData(data: data))  {
            trip?.addToRawEntries(entry)
            
            do{
                try entry.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("Could not create entry")
            }
        }       
    }
    
    
    
    @IBAction func takePhotoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Error", message: "Xcode doesn't have a camera to use, must use actual iPhone :(", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func choosePhotoButton(_ sender: Any) {
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagefromLibrary = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = imagefromLibrary
//            let imageData = imagefromLibrary.pngData() as NSData?
            
//            entry?.rawImage = imageData
            
        }
        
        dismiss(animated: true, completion: nil)
    }
 
    
    


}

extension NewEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
