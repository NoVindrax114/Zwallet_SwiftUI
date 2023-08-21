//
//  ProfileResponse.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 18/08/23.
//

import Foundation

struct ProfileResponse: Codable {
    var status: Int
    var message: String
    var data: DataProfileResponse
}

struct DataProfileResponse: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var phone: String
    var image: String
}
