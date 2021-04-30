import Foundation
import RealmSwift

@objc open class EmployeeModel: NSObject {
    var id: Int = 0
    var image: UIImage = UIImage()
    var name = ""
    var position = ""
    var salary = 0
    var age = 0
    var phoneNumber = ""
    
    private static let repository: EmployeeModelRepository = EmployeeModelRepository()
    
    override init() {}
    
    init(name: String, position: String, salary: Int ,age: Int, phoneNum: String, image: UIImage) {
        self.name = name
        self.position = position
        self.salary = salary
        self.age = age
        self.phoneNumber = phoneNum
        self.image = image
    }
    
}

extension EmployeeModel {
    static func save(entity: EmployeeModel) {
        repository.save(entity: entity)
    }
    
    func save() {
        repository.save(entity: self)
    }
    
    func save(entitys: [EmployeeModel]) {
        repository.save(entities: entitys)
    }
    
    @objc static func fetch(predicate: NSPredicate? = nil, sorted: Sort? = nil) -> [EmployeeModel] {
        return repository.fetch(predicate: predicate, sorted: sorted)
    }
    
    static func removeAll() {
        repository.removeAll()
    }
    
    @objc static func removeEmployee(id: Int) {
        let employeeModelBase = EmployeeModel.fetch()
        EmployeeModel.removeAll()
        for employee in employeeModelBase {
            if employee.id != id {
                employee.save()
          }
        }
      }
}

extension EmployeeModel {
    var repository: EmployeeModelRepository {
        let repository = EmployeeModelRepository()
        repository.id = id
        repository.name = name
        repository.position = position
        repository.salary = salary
        repository.age = age
        repository.phoneNumber = phoneNumber
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            repository.image = imageData
        }
        return repository
    }
}

extension Array where Element: EmployeeModel {
    var repositories: List<EmployeeModelRepository> {
        let repositories = List<EmployeeModelRepository>()
        
        for entity in self {
            let repository = entity.repository
            repositories.append(repository)
        }
        
        return repositories
    }
}
