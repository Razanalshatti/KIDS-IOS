

import Foundation
struct PointsTransferRequest: Codable{
    var id: Int
    var childId: Int
    var type: String
    var deductedPoints: Int
}
