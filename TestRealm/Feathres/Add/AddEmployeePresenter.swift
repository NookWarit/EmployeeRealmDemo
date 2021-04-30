import UIKit

class AddEmployeePresenter {
    weak var viewController: AddEmployeeDisplayLogic?
    
    required init() {
        
    }
}

extension AddEmployeePresenter: AddEmployeePresentationLogic {
    func presentInsertData(response: AddEmployee.InsertData.Response) {
        let viewModel = AddEmployee.InsertData.ViewModel()
        viewController?.displayInSertData(viewModel: viewModel)
    }
}
