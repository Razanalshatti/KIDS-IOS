

import Foundation
struct PointsTransferRequest: Codable{
    var Id: Int
    var ChildId: Int
    var TransferPointType: String
    var deductedPoints: Int
}
