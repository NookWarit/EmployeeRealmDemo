import Foundation

//MARK: ViewController
protocol EmployeeDisplayLogic: class {
    func displaySearchData(viewModel: Employee.SearchData.ViewModel)
    func displayDeleteData(viewModel: Employee.DeleteData.ViewModel)
}

//MARK: Interactor
protocol EmployeeBusinessLogic {
    func searchData(request: Employee.SearchData.Request)
    func deleteData(request: Employee.DeleteData.Request)
}

//MARK: Presenter
protocol EmployeePresentationLogic {
    func presentSearchdata(response: Employee.SearchData.Response)
    func presentDeleteData(response: Employee.DeleteData.Response)
}

//MARK: Routable
@objc protocol EmployeeRoutingLogic {
    func routeToAddEmployee()
    func routeToEditEmployee(employeeData: EmployeeModel)
}

//MARK: DataStore
protocol EmployeeDataStore {

}

//MARK: DataPassing
protocol EmployeeDataPassing {
    var dataStore: EmployeeDataStore? { get }
}
