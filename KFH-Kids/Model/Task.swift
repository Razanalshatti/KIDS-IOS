
import Foundation
struct Task: Codable {
    var Id: Int
    var ParentId: Int
    var TaskType: String
    var Description: String
    var Date: Date
    var Points: Int
    var childId: Int
    var dueDate: Date
    var isCompleted: Bool
    var Parent: Parent
    
}

