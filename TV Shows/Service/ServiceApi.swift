import Foundation
import Alamofire

class ServiceApi {
    
    static let shared = ServiceApi()
    
    var sessionManager: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        return manager
    }
    
    enum ResponseStatus {
        case success
        case error
    }

    enum Endpoint {
        case show
        case showDescription
        case showEpisodesDescription
        case episodeDetails
        case episodeDetailsComments
        case image
        case login
        case token
        case comment
        case addEpisode
        case addImage
    }
    
    fileprivate func getUrl(id: String = "", endpoint: Endpoint) -> String {
        let baseUrl = "https://api.infinum.academy"
        
        switch endpoint {
        case .show:
            return baseUrl + "/api/shows"
            
        case .image:
            return baseUrl + id
            
        case .showDescription:
            return  baseUrl + "/api/shows/\(id)"
            
        case .showEpisodesDescription:
            return baseUrl + "/api/shows/\(id)/episodes"
            
        case .episodeDetails:
            return baseUrl + "/api/episodes/\(id)"
            
        case .episodeDetailsComments:
            return baseUrl + "/api/episodes/\(id)/comments"
            
        case .login:
            return baseUrl + "/api/users"
            
        case .token:
            return baseUrl + "/api/users/sessions"
            
        case .comment:
            return baseUrl + "/api/comments"
            
        case .addImage:
            return baseUrl + "/api/media"
            
        case .addEpisode:
            return baseUrl + "/api/episodes"
        }
    }
    
    func postData(parameters: Parameters, endpoint: Endpoint, completionHandler: @escaping  (ResponseStatus) -> ()) {
        let url = getUrl(endpoint: endpoint)
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if endpoint == .login {
                        self.getToken(parameters: parameters, endpoint: .token, completionHandler: completionHandler)
                    } else {
                        completionHandler(.success)
                    }
 
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.error)
                }
        }
    }

    func postImage(data: Data, fileName: String, completionHandler: @escaping (ResponseStatus) -> ()) {
        let url = getUrl(endpoint: .addImage)
        
        sessionManager.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName: "avatar", fileName: fileName, mimeType: "image/png")
        }, to: url, method: .post) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completionHandler(.success)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionHandler(.error)
            }
        }
    }
    
    fileprivate func getToken(parameters: Parameters , endpoint: Endpoint, completionHandler: @escaping (ResponseStatus) -> ()) {
        let url = getUrl(endpoint: endpoint)
        
        sessionManager.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<UserToken>) in
                guard let myToken = response.result.value else {
                    return completionHandler(.error)
                }
                
                self.sessionManager.adapter = AccessTokenAdapter(accessToken: myToken.token)
                return completionHandler(.success)
        }
    }
    
    func getData<T: Decodable>(id: String = "", endpoint: Endpoint, type: T.Type, completionHandler: @escaping (T?, ResponseStatus) -> ()) {
        let url = getUrl(id: id, endpoint: endpoint)
        
        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<T>) in
                guard let showDetials = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(showDetials, .success)
        }
    }
    
    func getImage(id: String, completionHandler: @escaping (UIImage?) -> ()) {
        let url = getUrl(id: id, endpoint: .image)

        sessionManager.request(url).responseData { (response) in
            if let error = response.error {
                print("Failed to get image ", error.localizedDescription)
                return completionHandler(nil)
            }
            
            guard let imagedata = response.data else { return completionHandler(nil) }
            
            let image = UIImage(data: imagedata)
            return completionHandler(image)
        }
    }
    
    
}
