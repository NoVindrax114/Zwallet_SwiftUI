//
//  TokenConstant.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 18/08/23.
//

import Foundation

struct Constant {
    static var baseURL: String {
        return Bundle.main.infoDictionary?["http://54.158.117.176:8000"] as? String ?? ""
    }
    
    static let kAccessTokenKey = "AccessToken"
    static let kFirstnameKey = "firstname"
    static let kLastnameKey = "lastname"
    static let kEmail = "email"
    static let kPhone = "phone"
    static let kImage = "image"

    static var token: String {
        return UserDefaults.standard.value(forKey: "AccessToken") as? String ?? ""
    }
    static var firstName: String {
        return UserDefaults.standard.value(forKey: "firstname") as? String ?? ""
    }
    static var lastName: String {
        return UserDefaults.standard.value(forKey: "lastname") as? String ?? ""
    }
    static var email: String {
        return UserDefaults.standard.value(forKey: "email") as? String ?? ""
    }
    static var phone: String {
        return UserDefaults.standard.value(forKey: "phone") as? String ?? ""
    }
    static var image: String {
        return UserDefaults.standard.value(forKey: "image") as? String ?? ""
    }
}
