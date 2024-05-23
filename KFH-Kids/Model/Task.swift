
import Foundation
//struct Task : Codable {
//    var id: Int
//    var tarentId: Int
//    var taskType: String
//    var description: String
//    var date: Date
//    var points: Int
//    var children: String
//    let dueDate: Date
//    var isDone: Bool
//    var image: UIImage
//}


struct Task: Codable {
    var id: Int
    var ParentId: Int
    var taskType: String
    var description: String
    var date: Date
    var points: Int
    var children: String
    let dueDate: Date
    var isDone: Bool
}

