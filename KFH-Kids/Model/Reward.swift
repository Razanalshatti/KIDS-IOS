

import Foundation
struct Reward: Codable {
    var id: Int
    var ParentId: Int
    var rewardType: String
    var description: String
    var requiredPoints: Int
    var children: String
}
