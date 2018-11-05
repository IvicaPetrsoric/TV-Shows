import Foundation
import CodableAlamofire

struct EpisodeDetails: Decodable {
    
    let id: String
    let showId: String
    let title: String
    let description: String
    let episodeNumber: String
    let season: String
    let type: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case showId
        case title
        case description
        case episodeNumber
        case season
        case type
        case imageUrl

    }
}
