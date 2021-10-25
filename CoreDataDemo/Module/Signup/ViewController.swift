//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Bhavesh on 25/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var genderMaleChoice: UIButton!
    @IBOutlet weak var genderFemaleChoice: UIButton!
    
    var genderChoice = "" // Default

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func signupClicked(_ sender: UIButton) {
        signupAction()
    }
    
    @IBAction func genderMaleChoiceClicked(_ sender: UIButton) {
        clearGenderChoice()
        genderChoice = "male"
        genderMaleChoice.setImage(UIImage(systemName: "circle.fill"), for: .normal)
    }
    
    @IBAction func femaleMaleChoiceClicked(_ sender: UIButton) {
        clearGenderChoice()
        genderChoice = "female"
        genderFemaleChoice.setImage(UIImage(systemName: "circle.fill"), for: .normal)
    }
    
    fileprivate func clearGenderChoice() {
        genderChoice = ""
        genderMaleChoice.setImage(UIImage(systemName: "circle"), for: .normal)
        genderFemaleChoice.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    private func moveToHomeScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as! HomeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController {
    
    fileprivate func signupAction() {
        
        let inputValidate = isInputValidate()
        
        guard inputValidate.isValid else {
            showAlert(with: inputValidate.message)
            return
        }
        
        guard let userModel = getUserModel() else {
            return
        }
        
        UserCoreDataAction.shared.save(user: userModel)
        
        moveToHomeScreen()
        
    }
    
    fileprivate func isInputValidate() -> (isValid: Bool, message: String) {
        
        guard let firstName = firstNameTextField.text,
              !firstName.isEmpty else {
            return (false, "Please enter first Name")
        }
        
        guard let lastName = lastNameTextField.text,
              !lastName.isEmpty else {
            return (false, "Please enter last Name")
        }
        
        // here can also enhance email regex validate funcionality
        guard let emailAddress = emailAddressTextField.text,
              !emailAddress.isEmpty else {
            return (false, "Please enter email address")
        }
        
        guard !genderChoice.isEmpty else {
            return (false, "Please select gender")
        }
        
        guard let address = addressTextField.text,
              !address.isEmpty else {
            return (false, "Please enter address")
        }
        
        return (true, "Sucessfully Validated")
    }
    
    
    fileprivate func getUserModel() -> UserModel? {
        guard let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text,
           let email = emailAddressTextField.text,
           let image = UIImage(systemName: "person.circle.fill"),
           let address = addressTextField.text else {
            
            return nil
        }
        
        return UserModel(firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  image: image,
                                  gender: genderChoice,
                                  address: address)
    }
    
    
    
    
    fileprivate func showAlert(with message: String) {
        
        let alert = UIAlertController(title: "Core Data Demo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

