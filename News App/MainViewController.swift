import UIKit

final class MainViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News App"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        arrangeSubviews()
        setupViewConstraints()
    }
    
    
    func arrangeSubviews() {
        view.addSubview(titleLabel)
    }

    func setupViewConstraints() {
        var constraints: [NSLayoutConstraint] = []
        constraints += [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

