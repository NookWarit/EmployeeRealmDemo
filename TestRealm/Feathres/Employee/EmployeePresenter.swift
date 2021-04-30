import UIKit

class EmployeePresenter {
    weak var viewController: EmployeeDisplayLogic?
    
    required init() {
        
    }
}

extension EmployeePresenter: EmployeePresentationLogic {
    func presentSearchdata(response: Employee.SearchData.Response) {
        let viewModel = Employee.SearchData.ViewModel(data: response.data)
        viewController?.displaySearchData(viewModel: viewModel)
    }
    
    func presentDeleteData(response: Employee.DeleteData.Response) {
        let viewModel = Employee.DeleteData.ViewModel(data: response.data)
        viewController?.displayDeleteData(viewModel: viewModel)
    }
    
}
