//
//  SignupCoreDataAction.swift
//  CoreDataDemo
//
//  Created by Bhavesh on 25/10/21.
//

import UIKit
import CoreData

class UserCoreDataAction {
    
    static let shared: UserCoreDataAction = UserCoreDataAction()
    
    private init() { }
    
    private func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func saveContext(with context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Failed to save new user! \(error): \(error.userInfo)")
        }
    }
    
    func save(user model: UserModel) {
        let managedContext = getContext()
        let newUser = User(context: managedContext)
        newUser.firstName = model.firstName
        newUser.lastName = model.lastName
        newUser.emailAddress = model.email
        newUser.address = model.address
        
        saveContext(with: managedContext)
    }
    
    func fetchUsers(completion: @escaping (Result<[UserModel], DataBaseError>) -> Void) {
        let managedContext = getContext()
        fetch(type: User.self, managedObjectContext: managedContext) { [weak self] (userList: [User]?) in
            
            guard let userList = userList,
                  userList.count > 0 else {
                completion(.failure(.noDataFound(String(describing: UserModel.self))))
                return
            }
            
            let userEventModel = userList.map{ UserModel(from: $0) }
            completion(.success(userEventModel))
        }
    }

    
    // MARK: - Generic Fetch Helper Method
    private func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void)) {
        
        managedObjectContext.perform {
            let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: type))
            if let predicate = predicate {
                request.predicate = predicate
            }
            if let sortDescriptors = sortDescriptors {
                request.sortDescriptors = sortDescriptors
            }
            do {
                let result = try managedObjectContext.fetch(request)
                completion(result)
            } catch {
                completion(nil)
            }
        }
    }
    
}


// MARK: DataBase Error Customize
enum DataBaseError: Error {
    case badExcess
    case noDataFound(String)
}
