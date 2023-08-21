//
//  LoginResponse.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 18/08/23.
//

import Foundation

struct LoginResponse: Codable {
    var status: Int
    var message: String
    var data: DataLoginResponse
}

struct DataLoginResponse: Codable {
    var id: Int
    var email: String
    var token: String
}
