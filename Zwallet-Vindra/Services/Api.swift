//
//  Api.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 16/08/23.
//

import Foundation
import Moya

let BAS_URL = "http://54.158.117.176:8000"

enum Api {
    case login(email: String, password: String)
    case signUp(username: String, email: String, password: String)
    case resetPassword(email: String, password: String)
    case profile
    case logout(token: String)
}

extension Api: TargetType {
    var baseURL: URL {
        return URL(string: BAS_URL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signUp:
            return "/auth/signup"
        case .resetPassword:
            return "/auth/reset"
        case .profile:
            return "/user/myProfile"
        case .logout(let token):
            return "/auth/logout/\(token)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        case .resetPassword:
            return .patch
        case .profile:
            return .get
        case .logout:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        case .signUp(let username, let email, let password):
            return .requestParameters(parameters: ["username": username,"email": email, "password": password], encoding: URLEncoding.default)
        case .resetPassword(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        case .profile:
            return .requestPlain
        case .logout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .signUp, .resetPassword:
            return nil
        case .profile:
            return ["Authorization" : "Bearer \(Constant.token)"]
        case .logout(let token):
            return ["Authorization" : "Bearer \(token)"]
        }
    }
}

// ["Authorizaation" : "Bearer \(Contant.token)"]
