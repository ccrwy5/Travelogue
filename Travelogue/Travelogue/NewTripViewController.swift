//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/7/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        
        let trip = Trip(title: titleTextField.text ?? "")
        
        do{
            try trip?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
            print("Trip.title = " + (trip?.title!)! )
        }catch{
            print("Couldn't save")
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
    }
    
}

extension NewTripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
