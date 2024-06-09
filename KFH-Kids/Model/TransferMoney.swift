//
//  TransferMoney.swift
//  KFH-Kids
//
//  Created by Aseel on 09/06/2024.
//

import Foundation


struct TransferMoney: Codable {
    var amount: Int
}

struct TransferMoneyResponse: Codable {
    var message: String
}


/*
{
  "amount": 100
}
*/
