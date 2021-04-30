import UIKit

class EmployeeInteractor {
    var presenter: EmployeePresentationLogic?
    var worker: EmployeeWorker?

    required init() {
        worker = EmployeeWorker()
    }
}

extension EmployeeInteractor: EmployeeDataStore, EmployeeBusinessLogic {
    func searchData(request: Employee.SearchData.Request) {
        if request.searchText == "" {
            let res = EmployeeModel.fetch()
            presenter?.presentSearchdata(response: Employee.SearchData.Response(data: res))
            
        } else {
            presenter?.presentSearchdata(response: Employee.SearchData.Response(data: EmployeeModel.fetch().filter({ $0.name == request.searchText || "\($0.salary)" == request.searchText || $0.phoneNumber == request.searchText })))
        }
    }
    
    func deleteData(request: Employee.DeleteData.Request) {
        EmployeeModel.removeEmployee(id: request.id)
        let response = Employee.DeleteData.Response(data: EmployeeModel.fetch())
        presenter?.presentDeleteData(response: response)
    }
}
