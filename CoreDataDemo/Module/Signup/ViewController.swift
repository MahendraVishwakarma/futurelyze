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
        
        let userModel = getUserModel()
        
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
        
        guard let emailAddress = emailAddressTextField.text,
              !emailAddress.isEmpty else {
            return (false, "Please enter email address")
        }
        
        guard let address = addressTextField.text,
              !address.isEmpty else {
            return (false, "Please enter address")
        }
        
        return (true, "Sucessfully Validated")
    }
    
    
    fileprivate func getUserModel() -> UserModel {
        let userModel = UserModel(firstName: firstNameTextField.text!,
                                  lastName: lastNameTextField.text!,
                                  email: emailAddressTextField.text!,
                                  image: UIImage(systemName: "person.circle.fill")!,
                                  gender: "male",
                                  address: addressTextField.text!)
        
        return userModel
    }
    
    
    
    
    fileprivate func showAlert(with message: String) {
        
        let alert = UIAlertController(title: "Core Data Demo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

