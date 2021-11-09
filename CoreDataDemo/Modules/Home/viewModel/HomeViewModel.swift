//
//  HomeViewModel.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import Foundation

class HomeViewModel {
    var userList: [UserModel] = []
    weak var delegate: UserUpdateDelegate?
    
    func fetchData() {
        UserCoreDataAction.shared.fetchUsers { result in
            switch result {
            case .success(let users):
                self.userList = users
                self.delegate?.updateList(status: 1)
                break
            case .failure(_):
                self.delegate?.updateList(status: 0)
                break
            }
        }
    }
}
