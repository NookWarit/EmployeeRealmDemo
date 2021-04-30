import Foundation

//MARK: ViewController
protocol AddEmployeeDisplayLogic: class {
    func displayInSertData(viewModel: AddEmployee.InsertData.ViewModel)
}

//MARK: Interactor
protocol AddEmployeeBusinessLogic {
    func insertData(request: AddEmployee.InsertData.Request)
}

//MARK: Presenter
protocol AddEmployeePresentationLogic {
    func presentInsertData(response: AddEmployee.InsertData.Response)
}

//MARK: Routable
@objc protocol AddEmployeeRoutingLogic {
    func popViewController()
}

//MARK: DataStore
protocol AddEmployeeDataStore {

}

//MARK: DataPassing
protocol AddEmployeeDataPassing {
    var dataStore: AddEmployeeDataStore? { get }
}
