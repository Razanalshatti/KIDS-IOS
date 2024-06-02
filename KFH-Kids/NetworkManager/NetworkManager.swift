import Alamofire

//MARK: Check list ✅
/// 1- Check endpoint
/// 2- Check the Models are the same with backend
/// 3- Check the failure error and do debug!



class NetworkManager {
    
    private let baseURL = "https://kidsapi20240528084240.azurewebsites.net/api"
    static let shared = NetworkManager()
    
    // MARK: Login
    func login(child: Child, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let URL = baseURL + "Child/login"
        AF.request(URL, method: .post, parameters: child, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let login):
                completion(.success(login))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: GetTasks
    func GetTasks(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{childId}/GetTasks"
        AF.request(URL, method: .get, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let tasks):
                completion(.success(tasks))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: GetRewards
    func GetRewards(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{Id}/GetRewards"
        AF.request(URL, method: .get, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let rewards):
                completion(.success(rewards))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: task completion
    func taskCompletion(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{childId}/tasks/{taskId}/complete"
        AF.request(URL, method: .put, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let complete):
                completion(.success(complete))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: Balance
    func getTasks(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{childId}/balance"
        AF.request(URL, method: .get, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let balance):
                completion(.success(balance))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: GetPoints
    func GetPoints(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/GetPoints/{ChildId}"
        AF.request(URL, method: .get, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let points):
                completion(.success(points))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: transfer
    func transfer(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{parentId}/transfer/{childId}"
        AF.request(URL, method: .post, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let transfer):
                completion(.success(transfer))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    // MARK: ClaimRewards
    func ClaimRewards(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "Child/{childId}/claimedrewards"
        AF.request(URL, method: .get, parameters: child, encoder: URLEncodedFormParameterEncoder.default).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let tasks):
                completion(.success(tasks))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
}
