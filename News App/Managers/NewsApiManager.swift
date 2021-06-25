import Foundation

enum PathType: FinalURLPoint {
    var baseURL: URL {
        return URL(string: "https://newsapi.org")!
    }

    var path: String {
        switch self {
        case let .topHeadlines(country, apiKey):
            return "/v2/top-headlines?country=\(country)&apiKey=\(apiKey)"
        case let .image(url):
            return url
        }
    }

    var request: URLRequest {
        switch self {
        case .topHeadlines(_, _):
            let url = URL(string: path, relativeTo: baseURL)
            return URLRequest(url: url!)
        case .image(_):
            let url = URL(string: path)
            return URLRequest(url: url!)
        }
    }

    case topHeadlines(country: String, apiKey: String)
    case image(url: String)
}

final class NewsApiManager: NSObject, APIManager {
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue())
    }()

    lazy var imageCache: NSCache<NSString, NSData> = {
        NSCache<NSString, NSData>()
    }()

    var dataTask: URLSessionDataTask?

    func fetchNewsWith(country: String, apiKey: String, completionHandler:
        @escaping (APIResult<News>) -> Void) {
        let request = PathType.topHeadlines(country: country, apiKey: apiKey).request
        fetch(request: request) { result in
            completionHandler(result)
        }
    }
    
    func fetchImageWith(url: String, completionHandler:
        @escaping (APIResult<Data>) -> Void) {
        let request = PathType.image(url: url).request
        fetch(request: request) { result in
            completionHandler(result)
        }
    }
}
