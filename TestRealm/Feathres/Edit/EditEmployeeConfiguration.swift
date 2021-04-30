import Foundation

class EditEmployeeConfiguration {
    static let shared: EditEmployeeConfiguration = EditEmployeeConfiguration()
    
    func configure(_ viewController: EditEmployeeViewController) {
        let interactor = EditEmployeeInteractor()
        let presenter = EditEmployeePresenter()
        let router = EditEmployeeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
