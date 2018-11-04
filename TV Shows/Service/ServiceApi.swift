import Foundation
import Alamofire

class ServiceApi {
    
    static let shared = ServiceApi()
    
    fileprivate let authorizationHeader: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    fileprivate lazy var headers = ["Authorization": "\(authorizationHeader)"]
    fileprivate let baseUrl = "https://api.infinum.academy"
    
    enum ResponseStatus {
        case success
        case error
    }
    
    func login(email: String, password: String, completionHandler: @escaping (ResponseStatus) -> ()) {
        let url = baseUrl + "/api/users/sessions"
        
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
        let url = baseUrl + "/api/shows"
        
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
    
    func getShowsImage(byUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
        let imageUrl = baseUrl + byUrl
        
        Alamofire.request(imageUrl).responseData { (response) in
            if let error = response.error {
                print("Failed to fetch ShowsImage ", error.localizedDescription)
                return completionHandler(nil)
            }
            
            guard let imagedata = response.data else { return completionHandler(nil) }
            
            let image = UIImage(data: imagedata)
            return completionHandler(image)
        }
    }
    
    func getShowDescription(id: String, completionHandler: @escaping (ShowDetails?, ResponseStatus) -> ()) {
        let url = baseUrl + "/api/shows/\(id)"
        
        Alamofire
            .request(url,
                     method: .get,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<ShowDetails>) in
                guard let showDetials = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(showDetials, .success)
        }
    }
    
}
