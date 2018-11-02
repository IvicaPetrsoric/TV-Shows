import Foundation
import CodableAlamofire

struct Shows: Decodable {
    
    let id: String
    let title: String
    let imageUrl: String
    let likesCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case imageUrl
        case likesCount
    }
}
