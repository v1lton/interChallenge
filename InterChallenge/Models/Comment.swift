import Foundation

struct Comment: Codable, TitleAndDescription {
    let id: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id, postId, body
        case title = "name"
    }
}
