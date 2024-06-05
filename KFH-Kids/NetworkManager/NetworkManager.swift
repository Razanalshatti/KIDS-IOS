import Alamofire
import Foundation

//MARK: Check list ✅
/// 1- Check endpoint
/// 2- Check the Models are the same with backend
/// 3- Check the failure error and do debug!



class NetworkManager {
    
    private let baseURL = "https://kidsapi20240528084240.azurewebsites.net/api/"
    static let shared = NetworkManager()
    
    // MARK: Login
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
    
    
    
    // MARK: GetTasks
    func GetTasks(childId: Int, completion: @escaping (Result<[MyTask], Error>) -> Void) {
        //Child/1/GetTasks
        let URL = baseURL + "Child/\(childId)/GetTasks"
        AF.request(URL, method: .get).responseDecodable(of: [MyTask].self) { response in
            switch response.result {
            case .success(let tasks):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(tasks))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    
    // MARK: GetRewards
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
    func taskCompletion(childId: Int,taskId: Int, completion: @escaping (Result<[MyTask], Error>) -> Void) {
        let URL = baseURL + "Child/\(childId)/tasks/\(taskId)/complete"
        AF.request(URL, method: .put, parameters: [childId, taskId], encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [MyTask].self) { response in
            switch response.result {
            case .success(let complete):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(complete))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }

    
    // MARK: Balance
//    func getBalance(token: String childId: Int, completion: @escaping (Result<BalanceResponse, Error>) -> Void) {
//        let URL = baseURL + "Child/\(childId)/balance"
//        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//        AF.request(URL, method: .get, parameters: childId, encoder: JSONParameterEncoder.default, headers: headers).response { response in
//            switch response.result{
//            case .success(let data):
//                do {
//                    let balance = try JSONDecoder().decode(BalanceResponse.self, from: data ?? Data())
//                    completion(.success(balance))
//                    } catch {
//                        completion(.failure(error))
//                    }
//            case .failure(let afError):
//                completion(.failure(afError as Error))
//            }
//        }
//    }
// 
    
    // MARK: GetPoints
    func GetPoints(childId: Int, completion: @escaping (Result<PointsResponse, Error>) -> Void) {
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
    
    // MARK: transfer
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
    // MARK: ClaimRewards
    func ClaimRewards(childId: Int, rewardId: Int, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let URL = baseURL + "Child/\(childId)/claimedrewards/\(rewardId)"
        AF.request(URL, method: .post).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let claimedReward):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.success(claimedReward))
            case .failure(let afError):
                //MARK: EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: (\(str)")
                }
                completion(.failure(afError as Error))
            }
        }
    }

    
    // MARK: Fetch functions

        
}
