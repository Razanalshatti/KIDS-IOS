//
//  Reward.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 21/05/2024.
//

import Foundation
struct Reward: Codable {
    var id: Int
    var ParentId: Int
    var rewardType: String
    var description: String
    var requiredPoints: Int
    var children: String
}
