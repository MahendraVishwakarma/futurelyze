//
//  UserViewModel.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import Foundation

class UsersViewModel {
    
    func fetchUsers(gender:UsersGender){
        var url = ""
        switch gender {
        case .female:
            url = ""
        case .male:
            url = ""
        case .others:
            url = ""
        default:
            url = ""
        }
        
        
    }
}

enum UsersGender {
    case male
    case female
    case others
}
