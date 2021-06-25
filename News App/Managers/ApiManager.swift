import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol APIManager: AnyObject {
    var session: URLSession { get }
    var dataTask: JSONTask? { get set }
    var imageCache: NSCache<NSString, NSData> { get }

    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (APIResult<T>) -> Void)
}

extension APIManager {
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        dataTask = session.dataTask(with: request) { data, response, error in

            guard let HTTPResponse = response as? HTTPURLResponse else {
                completionHandler(nil, nil, error)
                return
            }

            if data == nil {
                if let error = error {
                    completionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200 ... 299: completionHandler(data, HTTPResponse, nil)
                default: print("We have got response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask!
    }
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (APIResult<T>) -> Void) {
        if let cachedImageData = imageCache.object(forKey: request.url!.absoluteString as NSString) as? T {
            completionHandler(.success(cachedImageData))
            return
        } else {
            dataTask = JSONTaskWith(request: request) { data, _, error in
                DispatchQueue.main.async {
                    guard let data = data else {
                        if let error = error {
                            completionHandler(.failure(error))
                        }
                        return
                    }

                    if let data = data as? T {
                        self.imageCache.setObject(NSData(data: data as! Data), forKey: request.url!.absoluteString as NSString)
                        completionHandler(.success(data))
                        return
                    }

                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
            dataTask?.resume()
        }
    }
}

