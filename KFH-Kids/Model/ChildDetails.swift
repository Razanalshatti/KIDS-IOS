//
//  ChildDetails.swift
//  KFH-Kids
//
//  Created by Aseel on 09/06/2024.
//

import Foundation

struct ChildDetails: Codable {
    let id: Int
    let username: String
    let password: String
    var points: Int
    let balance: Int
    let baitiAccountNumber: Int
    let savingsAccountNumber: Int
    let tasks: [String]?
}
