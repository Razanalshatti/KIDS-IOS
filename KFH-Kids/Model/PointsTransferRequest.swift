//
//  PointsTransferRequest.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 21/05/2024.
//

import Foundation
struct PointsTransferRequest: Codable{
    var id: Int
    var childId: Int
    var type: String
    var deductedPoints: Int
}
