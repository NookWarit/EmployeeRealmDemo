import UIKit

class EditEmployeeInteractor {
    var presenter: EditEmployeePresentationLogic?
    var worker: EditEmployeeWorker?
    
    required init() {
        worker = EditEmployeeWorker()
    }
}

extension EditEmployeeInteractor: EditEmployeeDataStore, EditEmployeeBusinessLogic {
    
    func updateData(request: EditEmployee.UpdateData.Request) {
        let test = EmployeeModel()
        test.id = request.id
        test.name = request.name
        test.position = request.position
        test.salary = request.salary
        test.age = request.age
        test.phoneNumber = request.phoneNumber
        test.image = request.image
        test.save()
    }
}
