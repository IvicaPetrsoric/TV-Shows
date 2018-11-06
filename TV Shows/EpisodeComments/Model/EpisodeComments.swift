import Foundation
import CodableAlamofire

struct EpisodeComments: Decodable {
    
    let id: String
    let episodeId: String
    let text: String
    let userEmail: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case episodeId
        case text
        case userEmail
    }
}

