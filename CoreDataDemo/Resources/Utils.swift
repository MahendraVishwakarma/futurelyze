//
//  Utils.swift
//  
//
//  Created by Mahendra Vishwakarma on 24/10/21.
//

import Foundation
class Utils {
    static let maleURL = "https://api.json-generator.com/templates/lg7YWYQ-Q-tf/data?access_token=a9rlwjhd74ek670kt66nf1tduv5m294kdxoxc39w"
    static let femaleURL = "https://api.json-generator.com/templates/gTEZ9DpgnIJE/data?access_token=a9rlwjhd74ek670kt66nf1tduv5m294kdxoxc39w"
}

//Result type
public enum Result<T, U> where U:Error {
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error {
     case failedRequest(String?)
}
// hTTPS methods type
public enum HttpsMethod {
    case Post
    case Get
    case Put
    case Delate
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
        case .Delate: return "Delete"
            
        }
        
    }
}
