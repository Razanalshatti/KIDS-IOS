import Alamofire

//MARK: Check list ✅
/// 1- Check endpoint
/// 2- Check the Models are the same with backend
/// 3- Check the failure error and do debug!



class NetworkManager {
    
    private let baseURL = "https://kidsapi20240528084240.azurewebsites.net/"
    static let shared = NetworkManager()
    
    // MARK: Login
    func login(child: Child, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let URL = baseURL + "api/Child/login"
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
    func getTasks(child: Child, completion: @escaping (Result<[Task], Error>) -> Void) {
        let URL = baseURL + "GetTasks"
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
