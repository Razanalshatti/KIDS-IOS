

import Foundation
struct Reward: Codable {
    var Id: Int
    var ParentId: Int
    var RewardType: String
    var Description: String
    var RequiredPoints: Int
    var children: String
    var ChildId: Int
}
