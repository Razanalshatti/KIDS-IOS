

import Foundation
struct Reward: Codable {
    var id: Int
    var rewardType: String
    var description: String
    let image: String?
    var requiredPoints: Int
    var childId: Int
    var children: String?
}

/*
 

"id":1,
 "rewardType":"babdood",
 "description":"work hard",
 "requiredPoints":100,
 "childId":1,
 "children":null}
 
 */
