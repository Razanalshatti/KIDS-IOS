

import Foundation
struct PointsTransferRequest: Codable{
    var Id: Int
    var childId: Int
    var pointsToTransfer: Int
    var TransferPointType: String
    var deductedPoints: Int
}
