//
//  UserModel.swift
//  CoreDataDemo
//
//  Created by Bhavesh on 25/10/21.
//

import UIKit

struct UserModel {
    var firstName: String
    var lastName: String
    var email: String
    var image: UIImage
    var gender: String
    var address: String
}

extension UserModel {
    init(from user: User) {
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.email = user.emailAddress ?? ""
        self.address = user.address ?? ""
        self.image = UIImage(systemName: "person.circle.fill")!
        self.gender = user.gender ?? ""
    }
}
