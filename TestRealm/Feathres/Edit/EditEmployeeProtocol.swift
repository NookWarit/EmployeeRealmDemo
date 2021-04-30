import Foundation

//MARK: ViewController
protocol EditEmployeeDisplayLogic: class {
    
}

//MARK: Interactor
protocol EditEmployeeBusinessLogic {
    func updateData(request: EditEmployee.UpdateData.Request)
}

//MARK: Presenter
protocol EditEmployeePresentationLogic {
    
}

//MARK: Routable
@objc protocol EditEmployeeRoutingLogic {
    func popViewController()
}

//MARK: DataStore
protocol EditEmployeeDataStore {

}

//MARK: DataPassing
protocol EditEmployeeDataPassing {
    var dataStore: EditEmployeeDataStore? { get }
}
