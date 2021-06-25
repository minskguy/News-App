import Foundation

struct Article: Codable {
//    let source: Source
//    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
