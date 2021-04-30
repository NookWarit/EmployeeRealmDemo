import Foundation

class AddEmployeeConfiguration {
    static let shared: AddEmployeeConfiguration = AddEmployeeConfiguration()
    
    func configure(_ viewController: AddEmployeeViewController) {
        let interactor = AddEmployeeInteractor()
        let presenter = AddEmployeePresenter()
        let router = AddEmployeeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
