//
//  AddEditFamilyViewController.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class AddEditFamilyMemberViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var familyMember: FamilyMember?
    var familyDelegate: FamilyMemberDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let family = familyMember {
            navigationItem.title = "Edit Family Member"
            nameTextField.text = family.name
            ageTextField.text = "\(family.age)"
            deleteButton.isHidden = false
            
        } else {
            navigationItem.title = "Add Family Member"
        }
    
        
    }
    @IBAction func save(_ sender: UIButton) {
        
        guard let name = nameTextField.text else {
            showAlert(title: "Error", message: "Enter a name")
            return
        }
        
        guard let age = Int16(ageTextField.text!) else {
            showAlert(title: "Error", message: "Enter a numberical age")
            return
        }
        
        if age < 0 || age > 130 {
            
            showAlert(title: "Error", message: "Enter an age between 0 130")
            return
        }
        
        if let existingFamilyMember = familyMember {
            existingFamilyMember.age = age
            existingFamilyMember.name = name
            familyDelegate!.modify(familyMember: existingFamilyMember)
        } else {
            familyDelegate!.newfamilyMember(name: name, age: age)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteFamilyMember(_ sender: UIButton) {
        familyDelegate?.delete(familyMember: familyMember!)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
