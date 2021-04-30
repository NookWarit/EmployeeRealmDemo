import Foundation

class EmployeeConfiguration {
    static let shared: EmployeeConfiguration = EmployeeConfiguration()
    
    func configure(_ viewController: EmployeeViewController) {
        let interactor = EmployeeInteractor()
        let presenter = EmployeePresenter()
        let router = EmployeeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
