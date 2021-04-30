import UIKit

class EditEmployeeRouter: NSObject, EditEmployeeRoutingLogic, EditEmployeeDataPassing {
    weak var viewController: EditEmployeeViewController?
    var dataStore: EditEmployeeDataStore?
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
