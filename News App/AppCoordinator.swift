import UIKit

class AppCoordinator: Coordinator {
    var navigationStack = [UIViewController]()
    var navigationController: UINavigationController
    weak var window: UIWindow?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationStack.append(mainViewController)
    }
    
    func start() {
        navigationController.pushViewController(navigationStack[0], animated: false)
    }
    
    func showDetailVC() {
        navigationController.pushViewController(navigationStack[1], animated: false)

    }
    
    func showMainVC() {
        navigationController.popViewController(animated: true)
    }
}
