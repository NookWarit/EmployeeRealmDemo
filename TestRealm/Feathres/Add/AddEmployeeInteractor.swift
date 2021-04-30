import UIKit

class AddEmployeeInteractor {
    var presenter: AddEmployeePresentationLogic?
    var worker: AddEmployeeWorker?

    required init() {
        worker = AddEmployeeWorker()
    }
}

extension AddEmployeeInteractor: AddEmployeeDataStore, AddEmployeeBusinessLogic {
    
    func insertData(request: AddEmployee.InsertData.Request) {
        let test = EmployeeModel(name: request.name, position: request.position, salary: request.salary, age: request.age, phoneNum: request.phoneNumber, image: request.image)
        if let lastObj = EmployeeModel.fetch().last {
            test.id = lastObj.id + 1
            test.save()
        } else {
            test.save()
        }
    }
}
