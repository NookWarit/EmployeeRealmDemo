import Foundation
import RealmSwift

@objc class EmployeeModelRepository: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var position = ""
    @objc dynamic var salary = 0
    @objc dynamic var age = 0
    @objc dynamic var phoneNumber = ""
    @objc dynamic var image: Data = Data()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension EmployeeModelRepository {
    func save(entity: EmployeeModel) {
        doCatch {
            try entity.repository.save()
        }
    }
    
    func save(entities: [EmployeeModel]) {
        doCatch {
            try entities.repositories.save()
        }
    }
    
    func fetch(predicate: NSPredicate? = nil, sorted: Sort? = nil) -> [EmployeeModel] {
        var entities = [EmployeeModel]()
        
        doCatch {
            entities = try fetch(model: EmployeeModelRepository.self, predicate: predicate, sorted: sorted).map { $0.entity }
        }
        
        return entities
    }
    
    func removeAll() {
        doCatch {
            try removeAll(model: EmployeeModelRepository.self)
        }
    }
}

extension EmployeeModelRepository {
    var entity: EmployeeModel {
        let entity = EmployeeModel()
        entity.id = id
        entity.name = name
        entity.position = position
        entity.age = age
        entity.salary = salary
        entity.phoneNumber = phoneNumber
        if !image.isEmpty, let image = UIImage(data: image) {
            entity.image = image
        }
        return entity
    }
}

extension List where Element: EmployeeModelRepository {
    var entities: [EmployeeModel] {
        var entities = [EmployeeModel]()
        
        for repository in self {
            let entity = repository.entity
            entities.append(entity)
        }
        
        return entities
    }
}
