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
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderMaleChoice: UIButton!
    @IBOutlet weak var genderFemaleChoice: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var genderChoice = "" // Default
    var isImageSelected = false
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapDatePickerToTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        userImageView.layer.cornerRadius = 50
        userImageView.clipsToBounds = true
    }
    
    
    // MARK:- IBAction
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
    
    @IBAction func editImageClicked(_ sender: UIButton) {
        self.editImageAction()
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
            showAlert(with: "user is not generated")
            return
        }
        
        UserCoreDataAction.shared.save(user: userModel)
        
        moveToHomeScreen()
        
    }
    
    fileprivate func isInputValidate() -> (isValid: Bool, message: String) {
        
        guard isImageSelected else {
            return (false, "Please select image")
        }
        
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
        
        guard let dateOfBirth = emailAddressTextField.text,
              !dateOfBirth.isEmpty else {
            return (false, "Please select date of Birth")
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
              let address = addressTextField.text,
              let image = userImageView.image,
              let dateOfBirth = dobTextField.text else {
            
            return nil
        }
        
        return UserModel(firstName: firstName,
                         lastName: lastName,
                         email: email,
                         image: image,
                         gender: genderChoice,
                         address: address,
                         dateOfBirth: dateOfBirth)
    }
    
    
    
    
    fileprivate func showAlert(with message: String) {
        
        let alert = UIAlertController(title: "Core Data Demo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    fileprivate func editImageAction() {
        let alert = UIAlertController(title: "Select Image", message: nil , preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { action in
            self.openGallery()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    fileprivate func mapDatePickerToTextField(){
        //Formate Date
        
        if #available(iOS 14, *)  {
            datePicker.preferredDatePickerStyle = .inline
        } else if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        } else {
            // fallback 
        }
        
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
        
    }
    
    @objc fileprivate func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        debugPrint(formatter.string(from: datePicker.date))
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc fileprivate func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        isImageSelected = true
        userImageView.image = image
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
}

