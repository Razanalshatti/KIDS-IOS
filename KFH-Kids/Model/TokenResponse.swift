

import Foundation

struct TokenResponse: Codable {
    let token: String
    let username: String
    let parentId: Int
    let points: Int
    let baitiAccountNumber: Int
    let savingsAccountNumber: Int
    let balance: Decimal
    let childId: Int
}

/*
 
({"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjIiLCJyb2xlIjoiQ2hpbGQiLCJuYmYiOjE3MTczMjY5MzUsImV4cCI6MTcxNzkzMTczNSwiaWF0IjoxNzE3MzI2OTM1fQ.yxlwMHG_BT_GvRHVLG48IlhFmjKc91ak9ZE9E-6ET6o",
    "username":"razan",
 "parentId":1,
 "points":0,
 "baitiAccountNumber":0,
 "savingsAccountNumber":0,
 "balance":0.00,
 "childId":2,
 "parentChildRelationships":null,
 "tasks":[]}

*/
