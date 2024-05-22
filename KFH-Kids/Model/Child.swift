//
//  Child.swift
//  KFH-Kids
//
//  Created by Aseel on 21/05/2024.
//

import Foundation
struct Child : Codable {
    let id: Int
    let username: String
    let password: String
    let parentId: Int
    let points: Int
    let baityAccountNumber: Int
    let savingAccountingNumber: Int
    let tasks: String
    let request: String
}
