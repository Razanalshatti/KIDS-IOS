

import Foundation
struct Reward: Codable {
    var id: Int
    var rewardType: String
    var description: String
    var requiredPoints: Int
    var children: String?
    var childId: Int
}

/*
 

"id":1,
 "rewardType":"babdood",
 "description":"work hard",
 "requiredPoints":100,
 "childId":1,
 "children":null}
 
 */
