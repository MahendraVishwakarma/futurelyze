//
//  UserList.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import Foundation


// MARK: - UsersListElement
struct UsersListData: Codable {
    let id, name, gender, address: String?
    let company: String?
}

typealias UsersList = [UsersListData]
