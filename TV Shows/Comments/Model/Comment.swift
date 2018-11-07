import Foundation
import CodableAlamofire

struct Comment: Decodable {
    
    let id: String
    let episodeId: String
    let text: String
    let userEmail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case episodeId
        case text
        case userEmail
    }
}

