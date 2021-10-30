//
//  UserModel.swift
//  CoreDataDemo
//
//  Created by Madhuri on 25/10/21.
//

import UIKit

struct UserModel {
    var firstName: String
    var lastName: String
    var email: String
    var image: UIImage
    var gender: String
    var address: String
    var dateOfBirth: String
}

extension UserModel {
    init(from user: User) {
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.email = user.emailAddress ?? ""
        self.address = user.address ?? ""
        
        self.gender = user.gender ?? ""
        self.dateOfBirth = user.dateOfBirth ?? ""
        
        if let imageData = user.image,
           let image = UIImage(data: imageData) {
            self.image = image
        } else {
            self.image = UIImage(systemName: "person.circle.fill")!
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
       
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
