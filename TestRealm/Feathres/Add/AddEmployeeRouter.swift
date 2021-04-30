import UIKit

class AddEmployeeRouter: NSObject, AddEmployeeRoutingLogic, AddEmployeeDataPassing {
    weak var viewController: AddEmployeeViewController?
    var dataStore: AddEmployeeDataStore?
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }

}
