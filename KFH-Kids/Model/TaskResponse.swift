//
//  TaskResponse.swift
//  KFH-Kids
//
//  Created by Nada Alshaibani on 05/06/2024.
//

import Foundation

struct TaskResponse: Decodable {
    var tasks: [MyTask]
     var totalTasks: Int
}
