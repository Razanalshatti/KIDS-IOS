

import Foundation
import Alamofire


class NetworkManager {
    
    private let baseURL = "https://kidsapi20240528084240.azurewebsites.net/"
    static let shared = NetworkManager()

/* ENDPOINTS : post -> login - GetTasks - GetRewards - put -> complete - balance - GetPoints - post -> transfer - */
    
    
    // MARK: Login
    func login(child: Child, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let URL = baseURL + "login"
        AF.request(URL, method: .post, parameters: child, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    // MARK: Fetch
    
    
    
}
