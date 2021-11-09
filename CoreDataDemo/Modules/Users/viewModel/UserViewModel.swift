//
//  UserViewModel.swift
//  CoreDataDemo
//
//  Created by Mahendra Vishwakarma on 30/10/21.
//

import Foundation
import Action
import RxRelay
import RxSwift

protocol UsersViewModelInput: BaseViewModelInput {
    var fetchUsersAPI: CocoaAction { get }
}
protocol UsersViewModelOuput: BaseViewModelOuput {
    var selectedObservable: BehaviorRelay<UsersGender?> { get }
    var selectedGender:UsersGender? {get set}
}
protocol UsersViewModelType {
  var inputs: UsersViewModelInput { get }
  var outputs: UsersViewModelOuput { get }
}

class UsersViewModel:BaseViewModel, UsersViewModelInput, UsersViewModelOuput, UsersViewModelType {
    var userList:UsersList?
    
    var inputs: UsersViewModelInput { return self }
    var outputs: UsersViewModelOuput { return self }
    
    var selectedObservable = BehaviorRelay<UsersGender?>(value: .male)
    var selectedGender: UsersGender? {
           get {
            return selectedObservable.value
           }
           set {
            selectedObservable.accept(newValue)
           }
       }
    
    lazy var fetchUsersAPI: CocoaAction = {
        CocoaAction { [unowned self] in
            return self.fetchUsers(gender: self.selectedGender ?? .male)
        }
    }()
    
    func fetchUsers(gender:UsersGender) -> Observable<Void> {
       
        var url = ""
        switch gender {
        case .female:
            url = Utils.femaleURL
        case .male:
            url = Utils.maleURL
        case .others:
            url = Utils.maleURL
       
        }
        self.baseStateProperty.onNext(.loading)
        WebServices.requestHttp(urlString: url, method: .Get, param: nil, decode: { (json) -> UsersList? in
            guard let response = json as? UsersList else{
                return nil
            }
            return response
            
        }) { [weak self] (result) in
            
            switch result {
            case .success(let response) :
                if let data = response {
                    
                    self?.baseStateProperty.onNext(.finished)
                    
                    self?.outputs.baseStateObservable.subscribe(onNext: { [weak self] model in
                        self?.userList = data
                       
                    }).dispose()
                    
                }else {
                    self?.baseStateProperty.onNext(.failed)
                }
                break
            case .failure(let error) :
                print(error.localizedDescription)
                self?.baseStateProperty.onNext(.failed)
                
                break
            }
            
        }
        
        return .empty()
    }
    
    
}

protocol UserUpdateDelegate:AnyObject {
    func updateList(status:Int)
}


enum UsersGender {
    case male
    case female
    case others
}
