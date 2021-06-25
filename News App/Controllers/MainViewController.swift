import UIKit

final class MainViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    
    private let cellReuseIdentifier = "cell"
    
    private var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBar: UISearchBar = UISearchBar()
    
    lazy var presenter = MainViewPresenter(with: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "NewsCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        configureUI()
    }
    
    @objc func handleShowSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        navigationItem.rightBarButtonItem = nil
        searchBar.becomeFirstResponder()
    }
    
    func configureUI() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationItem.title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        
        arrangeSubviews()
        setupViewConstraints()
    }
    
    func arrangeSubviews() {
        view.addSubview(newsTableView)
    }
    
    func setupViewConstraints() {
        var constraints: [NSLayoutConstraint] = []
        constraints += [
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: MainViewPresenterOutputDelegate {
    func updateNews() {
        newsTableView.reloadData()
    }
    
    func getError(_ error: Error) {
        print(error)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsList?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? NewsCell else {
            return UITableViewCell()
        }
        let article = presenter.newsList?.articles[indexPath.row]
        cell.newsTitle.text = article?.title
        presenter.getImageWith(url: article?.urlToImage, imageView: cell.newsImage)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy - h:mm a"
        let date = dateFormatterGet.date(from: article?.publishedAt ?? "1:23 - June 2, 2021")
        cell.newsDate.text = dateFormatterPrint.string(from: date!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.cellTapped()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        searchBar.showsCancelButton = false
    }
}


