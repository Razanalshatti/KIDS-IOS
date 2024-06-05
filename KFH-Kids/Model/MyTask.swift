
import Foundation
struct MyTask: Codable {
    var id: Int
    var parentId: Int
    var taskType: String
    var description: String
    var date: String // Date represented as String
    var points: Int
    var childId: Int
    var category: String? // Assuming category is a String
    var categoryId: Int? // Assuming categoryId is an Int
    var isCompleted: Bool
    var parent: String? // Assuming parent is a String
      
}

