import Foundation
import CodableAlamofire

struct UploadImageData: Decodable {
    
    let id: String
    let path: String
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case path
        case type
    }
}
