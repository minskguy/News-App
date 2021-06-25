import Foundation

enum CodingKeys: String, CodingKey {
    case source, author, title
    case articleDescription = "description"
    case url, urlToImage, publishedAt, content
}
