//
//  CompletedTask.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 21/05/2024.
//

import Foundation
struct CompletedTask: Codable{
    var id: Int
    var taskId: Int
    var date: String
    var children: String
}
