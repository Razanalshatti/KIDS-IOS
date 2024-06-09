//
//  UpdateChildDetailsRequest.swift
//  KFH-Kids
//
//  Created by Aseel on 09/06/2024.
//

import Foundation

struct UpdateChildDetailsRequest: Codable {
    let id: Int
    let username: String
    let password: String
    let points: Int
    let savingsAccountNumber: Int
    let balance: Int
}


struct UserDetailsResponse: Codable {
    let id: Int
    let username: String
    let password: String
    let points: Int
    let balance: Int
    let baitiAccountNumber: Int
    let savingsAccountNumber: Int
    let tasks: [MyTask]?
}




