import Foundation

struct News: Codable {
//    let status: String
    let totalResults: Int
    let articles: [Article]
}
