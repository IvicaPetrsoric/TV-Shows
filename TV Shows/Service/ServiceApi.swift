import Foundation
import Alamofire

//import Foundation
import CodableAlamofire

struct UserToken: Decodable {
    
    let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token
    }
}


class ServiceApi {
    
    static let shared = ServiceApi()
    
    fileprivate let baseUrl = "https://api.infinum.academy"
    
    enum ResponseStatus {
        case success
        case error
    }
    
    //    email: ios.team@infinum.hr
    //    password: infinum1
    
//    let sessionManager = SessionManager()
    
    var sessionManager: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        return manager
    }
    
    func login(email: String, password: String, completionHandler: @escaping (ResponseStatus) -> ()) {
        var url = baseUrl + "/api/users"
        
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Logiran")
                    //                    completionHandler(.success)
                    
                case .failure:
                    print("error login")
                    //                    completionHandler(.error)
                }
        }
        
        url = baseUrl + "/api/users/sessions"
        
        
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default)
            //                          headers: headers)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<UserToken>) in
                guard let myToken = response.result.value else {
                    return completionHandler(.error)
                    
                }
                self.token = myToken.token
                print("myToken \(myToken)")
                
                self.sessionManager.adapter = AccessTokenAdapter(accessToken: self.token)
                
                
                //                let sessionManager = SessionManager()
                //                sessionManager.adapter = AccessTokenAdapter(accessToken: self.token)
                //
                //                print(sessionManager.request(self.baseUrl))
                
                
                return completionHandler(.success)
                
                
                
        }
        
        
    }
    
    fileprivate var token = ""
    
    func getShows(completionHandler: @escaping ([Shows]?, ResponseStatus) -> ()) {
        let url = baseUrl + "/api/shows"
        
        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<[Shows]>) in
                guard let myShows = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(myShows, .success)
        }
    }
    
    func getShowsImage(byUrl: String, completionHandler: @escaping (UIImage?) -> ()) {
        let imageUrl = baseUrl + byUrl
        
        sessionManager.request(imageUrl).responseData { (response) in
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
        
        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<ShowDetails>) in
                guard let showDetials = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(showDetials, .success)
        }
    }
    
    func getShowEpisodesDescription(id: String, completionHandler: @escaping ([ShowEpisodesDetaills]?, ResponseStatus) -> ()) {
        let url = baseUrl + "/api/shows/\(id)/episodes"
        
        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<[ShowEpisodesDetaills]>) in
                guard let showEpisodesDetials = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(showEpisodesDetials, .success)
        }
    }
    
    func getEpisodeDetails(id: String, completionHandler: @escaping (EpisodeDetails?, ResponseStatus) -> ()) {
        let url = baseUrl + "/api/episodes/\(id)"
//        self.sessionManager.session.configuration.timeoutIntervalForRequest = 10
        self.sessionManager.session.configuration.timeoutIntervalForResource = 5

        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<EpisodeDetails>) in
                guard let episodesDetials = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(episodesDetials, .success)
        }
    }
    
    func getEpisodeDetailsComments(id: String, completionHandler: @escaping ([Comment]?, ResponseStatus) -> ()) {
        let url = baseUrl + "/api/episodes/\(id)/comments"
        
        sessionManager.request(url,
                               method: .get,
                               encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) { (response: DataResponse<[Comment]>) in
                guard let episodeComments = response.result.value else { return completionHandler(nil, .error) }
                return completionHandler(episodeComments, .success)
        }
    }
    
    func postEpisodeDetailsComment(id: String, text: String, completionHandler: @escaping  (ResponseStatus) -> ()) {
        let url = baseUrl + "/api/comments"
        
        let parameters: Parameters = [
            "text": text,
            "episodeId": id
        ]
        
        sessionManager.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    completionHandler(.success)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.error)
                }
        }
    }
    
    func uploadImage(data: Data, name: String) {
//        let imageData = UIImagePNGRepresentation(image)!
        let url = baseUrl + "/api/media"
        
//        Alamofire.upload(data, to: url).responseJSON { response in
//            print(response)
//        }
        
//        let fileURL = URL(string:"file://"+path)
//        
//        let parameters: Parameters = [
//            "email": "ios.team@infinum.hr",
//            "password": "infinum1"
//        ]
//        
//        
//        
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append(fileURL, withName: "file")
//        },
//            to: url,
//            headers:headers,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.validate(statusCode: 200..<300)
//                        .responseJSON { response in
//                            
//                            switch response.result {
//                            case .success:
//                                debugPrint(response)
//                                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                                    print("Data: \(utf8Text)")
//                                    
//                                    let dict = self.convertToDictionaryAny(text: utf8Text)
//                                    
//                                    let fileName = dict!["fileName"]! as! String
//                                    print (fileName)
//                                    
//                                    if fileURL.pathExtension == "jpg" {
//                                        self.thumbnailName = fileName
//                                    }
//                                    if fileURL.pathExtension == "json" {
//                                        self.jsonName = fileName
//                                    }
//                                    
//                                    self.callPatchIfAllDataIsReady()
//                                }
//                            case .failure(let error):
//                                print(error)
//                                
//                                if let statusCode = response.response?.statusCode, statusCode == 400 {
//                                    PromptDialog.error(error)
//                                } else {
//                                    PromptDialog.error(error)
//                                }
//                            }
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        })
        
        
//        let urlRequest = urlRequestWithComponents(url, parameters: parameters, imageData: data)
//
//        Alamofire.upload(urlRequest.0, urlRequest.1)
//            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                println("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
//            }
//            .responseJSON { (request, response, JSON, error) in
//                println("REQUEST \(request)")
//                println("RESPONSE \(response)")
//                println("JSON \(JSON)")
//                println("ERROR \(error)")
//        }

        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//
//            multipartFormData.append(data, withName: name, fileName: "\(name).jpg", mimeType: "image/jpg")
//
//            for (key, value) in parameters {
//                multipartFormData.append((value as AnyObject).dataUsingEncoding(String.Encoding.utf8)!, withName: key)
//
//            }
//
//            }, to: url, method: .post, headers: headers,
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//                        upload.response { [weak self] response in
//                            guard let strongSelf = self else {
//                                return
//                            }
//                            debugPrint(response)
//                        }
//                    case .failure(let encodingError):
//                        print("error:\(encodingError)")
//                    }
//
//        })
    }
    
    
    
    
}

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://api.infinum.academy") {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}

