import Alamofire
import Foundation

//MARK: Check list ✅
/// 1- Check endpoint
/// 2- Check the Models are the same with backend
/// 3- Check the failure error and do debug!



class NetworkManager {
    
    private let baseURL = "https://kidsapi20240528084240.azurewebsites.net/api/"
    static let shared = NetworkManager()
    
    // MARK: Login - ✅
    func login(child: Child, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let URL = baseURL + "Child/login"
        AF.request(URL, method: .post, parameters: child, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let login):
                
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(login))
                
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                print("Raw response: (\(str)")
            }
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    
    // MARK: GetTasks - ✅
    func GetTasks(childId: Int, completion: @escaping (Result<[MyTask], Error>) -> Void) {
        //Child/1/GetTasks
        let URL = baseURL + "Child/\(childId)/GetTasks"
        
        AF.request(URL, method: .get).responseDecodable(of: [MyTask].self) { response in
            switch response.result {
            case .success(let tasks):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(tasks))
            case .failure(let afError):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Failed to fetch, the response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    // MARK: GetRewards - ✅
    func GetRewards(childId: Int,parentId:Int ,completion: @escaping (Result<[Reward], Error>) -> Void) {
        let URL = baseURL + "Child/\(childId)/GetRewards?parentId=\(parentId)"
        AF.request(URL, method: .get).responseDecodable(of: [Reward].self) { response in
            switch response.result {
            case .success(let rewards):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(rewards))
            case .failure(let afError):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }

    
    // MARK: task completion
//    func taskCompletion(childId: Int,taskId: Int, completion: @escaping (Result<[MyTask], Error>) -> Void) {
//        let URL = baseURL + "Child/\(childId)/tasks/\(taskId)/complete"
//        AF.request(URL, method: .put).responseDecodable(of: [MyTask].self) { response in
//            switch response.result {
//            case .success(let complete):
//                //MARK: EXTRA LINE FOR DEBUGGING
//                if let data = response.data, let str = String(data: data, encoding: .utf8) {
//                    print("Raw response 1: (\(str)")
//                }
//                completion(.success(complete))
//            case .failure(let afError):
//                //MARK: EXTRA LINE FOR DEBUGGING
//                if let data = response.data, let str = String(data: data, encoding: .utf8) {
//                    print("Raw response 2: (\(str)")
//                }
//                completion(.failure(afError as Error))
//            }
//        }
//    }
    func taskCompletion(childId: Int, taskId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let URL = baseURL + "Child/\(childId)/tasks/\(taskId)/complete"
        AF.request(URL, method: .put).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseDict = json as? [String: Any], let message = responseDict["message"] as? String {
                    // For debugging
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        print("Raw response 1: \(str)")
                    }
                    completion(.success(message))
                } else {
                    // Handle unexpected response format
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"])))
                }
            case .failure(let afError):
                // For debugging
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response 2: \(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }

    
    // MARK: Balance - ✅

    func getBalance(childId: Int, completion: @escaping (Result<BalanceResponse, Error>) -> Void) {
        let URL = baseURL + "Child/\(childId)/balance"
        AF.request(URL, method: .get).responseDecodable(of: BalanceResponse.self) { response in
            
            switch response.result {
            case .success(let balanceResponse):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(balanceResponse))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
 
  
    
    // MARK: GetPoints ✅
    func getPoints(childId: Int, completion: @escaping (Result<PointsResponse, Error>) -> Void) {
        let URL = baseURL + "Child/GetPoints/\(childId)"
        
        AF.request(URL, method: .get).responseDecodable(of:PointsResponse.self) {response in
        switch response.result {
            case .success(let pointsResponse):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(pointsResponse))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: GetChildDetails ✅
    func getChildDetails(childId: Int, completion: @escaping (Result<ChildDetails, Error>) -> Void) {
        let URL = baseURL + "Parent/ChildDetails/\(childId)"
        
        AF.request(URL, method: .get).responseDecodable(of: ChildDetails.self) { response in
            switch response.result {
            case .success(let childDetails):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.success(childDetails))
            case .failure(let afError):
                // MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    // MARK: UpdateChildDetails ✅
    func updateChildDetails(childId: Int, updateRequest: UpdateChildDetailsRequest, completion: @escaping (Result<UserDetailsResponse, Error>) -> Void) {
        
        let URL = baseURL + "Parent/ChildDetails/\(childId)"
        AF.request(URL, method: .patch, parameters: updateRequest, encoder: JSONParameterEncoder.default).response { response in
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                       print("updateChildDetails response: \(str)")
                   } else {
                       print("No data received")
                   }
            
            print("Status Code: \(response.response?.statusCode ?? 0)")
            print("Headers: \(response.response?.allHeaderFields ?? [:])")
            
            switch response.result {
            case .success(let data):
                do {
                    let updatedDetails = try JSONDecoder().decode(UserDetailsResponse.self, from: data ?? Data())
                    completion(.success(updatedDetails))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }





    
    // MARK: transfer points!
    func transfer(parentId: Int,childId: Int,transferPoints:Int, completion: @escaping (Result<Transfer, Error>) -> Void) {
        
        let URL = baseURL + "Child/\(parentId)/transfer/\(childId)"
                
        let transfer = Transfer(pointsToTransfer: transferPoints, trasferType: "", childId: "", type: "")
      
    
        AF.request(URL, method: .post, parameters: transfer, encoder: JSONParameterEncoder.default).responseDecodable(of: Transfer.self) { response in
            switch response.result {
            case .success(let transfer):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(transfer))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: transfer points!
    func transferMoney(childId: Int,transferMoney:Int, completion: @escaping (Result<TransferMoneyResponse, Error>) -> Void) {
        
        let URL = baseURL + "Child/\(childId)/transfer-to-baitiaccount"
                
        let transfer = TransferMoney(amount:transferMoney)
    
        AF.request(URL, method: .post, parameters: transfer, encoder: JSONParameterEncoder.default).responseDecodable(of: TransferMoneyResponse.self) { response in
            switch response.result {
            case .success(let transfer):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(transfer))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    //https://kidsapi20240528084240.azurewebsites.net/api/Child/2/transfer-to-baitiaccount


    // MARK: - ClaimReward
        func claimReward(id: Int, rewardId: Int, childId: Int, claimDate: String, completion: @escaping (Result<ClaimReward, Error>) -> Void) {
            let URL = baseURL + "Child/\(childId)/claimThisReward"

            let claim = ClaimReward(id: id, rewardId: rewardId, childId: childId, claimDate: claimDate)
            
            AF.request(URL, method: .post, parameters: claim, encoder: JSONParameterEncoder.default).responseDecodable(of: ClaimReward.self) { response in
                switch response.result {
                case .success(let claimReward):
                    // MARK: - EXTRA LINE FOR DEBUGGING
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        print("Success Raw response claimReward: (\(str))")
                    }
                    completion(.success(claimReward))
                case .failure(let afError):
                    // MARK: - EXTRA LINE FOR DEBUGGING
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        print("Failed Raw response claimReward (\(str))")
                    }
                    completion(.failure(afError as Error))
                }
            }
        }
    
    // MARK: Fetch functions

        
}
