import UIKit

class EmployeeRouter: NSObject, EmployeeRoutingLogic, EmployeeDataPassing {
    weak var viewController: EmployeeViewController?
    var dataStore: EmployeeDataStore?
    
    func routeToAddEmployee() {
        let vc = viewController?.storyboard?.instantiateViewController(withIdentifier: "AddEmployeeViewController") as! AddEmployeeViewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToEditEmployee(employeeData: EmployeeModel) {
        let vc = viewController?.storyboard?.instantiateViewController(withIdentifier: "EditEmployeeViewController") as! EditEmployeeViewController
        vc.employeeData = employeeData
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
