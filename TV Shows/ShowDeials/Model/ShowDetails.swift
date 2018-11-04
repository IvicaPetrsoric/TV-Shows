import Foundation
import CodableAlamofire

struct ShowDetails: Decodable {
    
    let id: String
    let title: String
    let imageUrl: String
    let likesCount: Int
    let type: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case imageUrl
        case likesCount
        case description
        case type
    }
}
