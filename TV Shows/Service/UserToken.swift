import CodableAlamofire

struct UserToken: Decodable {
    
    let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token
    }
}
