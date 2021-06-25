import UIKit

protocol MainViewPresenterOutputDelegate: class {
    func getError(_ error: Error)
    func updateNews()
}

class MainViewPresenter {
    private let apiManager = NewsApiManager()
    private(set) var newsList: News?
    weak var view: MainViewPresenterOutputDelegate?
    init(with view: MainViewPresenterOutputDelegate) {
        self.view = view
    }
    
    func getNews() {
        apiManager.fetchNewsWith(country: AppConstants.country, apiKey: AppConstants.apiKey) {
            [weak self] result  in
            switch result {
            case let .failure(error):
                self?.view?.getError(error)
                
            case let .success(news):
                self?.newsList = news
                self?.view?.updateNews()
            }
        }
    }
    func getImageWith(url: String?, imageView: UIImageView) -> Void {
        guard let urlString = url else {
            debugPrint("Missing URL")
            imageView.image = UIImage(named: "imageNotFound")
            return
        }
        
        apiManager.fetchImageWith(url: urlString) {
            [weak self] result in
            switch result {
            case let .failure(error):
                imageView.image = UIImage(named: "imageNotFound")
                self?.view?.getError(error)
            case let .success(image):
                imageView.image = UIImage(data: image)
            }
        }
    }
}
