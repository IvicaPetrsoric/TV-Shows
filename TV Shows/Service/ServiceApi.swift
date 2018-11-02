import Foundation
import Alamofire

class ServiceApi {
    
    static let shared = ServiceApi()
    
    fileprivate let authorizationHeader: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    fileprivate lazy var headers = ["Authorization": "\(authorizationHeader)"]
    fileprivate let baseUrl = "https://api.infinum.academy/api/"
    
    enum ResponseStatus {
        case success
        case error
    }
    
    func login(email: String, password: String, completionHandler: @escaping (ResponseStatus) -> ()) {
        let url = baseUrl + "users/sessions"
        
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    completionHandler(.success)
                    
                case .failure:
                    completionHandler(.error)
                }
        }
    }
    
    func getShows(completionHandler: @escaping ([Shows]?, ResponseStatus) -> ()) {
        let url = baseUrl + "shows"
        
        Alamofire
            .request(url,
                     method: .get,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<[Shows]>) in
                guard let myShows = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(myShows, .success)
        }
    }
    
}
