import Foundation
import Alamofire

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://api.infinum.academy"), !accessToken.isEmpty {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}
