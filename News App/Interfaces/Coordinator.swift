import UIKit

protocol Coordinator {
    var navigationStack: [UIViewController] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
