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
    
}


/*
 
 
 
 
 let parameters: Parameters = [
 "email": "ios.team@infinum.hr",
 "password": "infinum12"
 ]
 
 Alamofire.request("https://api.infinum.academy/api/users/sessions",
 method: .post,
 parameters: parameters,
 encoding: JSONEncoding.default,
 headers: headers)
 .validate()
 .responseJSON { response in
 //            print("Request: \(response.request)")
 //            print("Response: \(response.response)")
 //            print("Error: \(response.error)")
 
 switch response.result {
 case .success:
 print("Response data: ", response.data)
 break
 //                    PromptDialog.inform("Your illustration has been submitted!")
 //                    self.handleBackButton()
 case .failure(let error):
 print(error)
 
 if let statusCode = response.response?.statusCode, statusCode == 400 {
 //                        PromptDialog.error(error)
 } else {
 //                        PromptDialog.error(error)
 }
 }
 }
 
 
 
 //        Alamofire
 //            .request("https://someurl.com/login",
 //                     method: .post,
 //                     parameters: parameters,
 //                     encoding: JSONEncoding.default)
 //            .validate()
 //            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<User>) in
 //                let user = response.result.value
 //                print(user)
 //        }
 */
