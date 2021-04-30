import Foundation
import RealmSwift

//MARK: Auto increment
public extension Object {
    func autoIncrement<T: Object>(model: T.Type, by property: String) throws -> Int {
        return try autoIncrement(model: model, by: property)
    }
    
    static func autoIncrement<T: Object>(model: T.Type, by property: String) throws -> Int {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        let id = (realm.objects(model as Object.Type).max(ofProperty: property) as Int? ?? 0) + 1
        
        return id
    }
}

//MARK: Insert
public extension Object {
    @available(swift 5.0)
    func save() throws {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        try realm.write {
            realm.add(self, update: .all)
        }
    }
}

public extension List where Element: Object {
    @available(swift 5.0)
    func save() throws {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        try realm.write {
            realm.add(self, update: .all)
        }
    }
}

//MARK: Remove & Reset
public extension Object {
    func removeAll<T: Object>(model: T.Type, predicate: NSPredicate? = nil) throws {
        try Object.removeAll(model: model, predicate: predicate)
    }
    
    static func removeAll<T: Object>(model: T.Type, predicate: NSPredicate? = nil) throws {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        var objects = realm.objects(model as Object.Type)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        try realm.write {
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func reset() throws {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        try realm.write {
            realm.deleteAll()
        }
    }
}

//MARK: Fetch
public extension Object {
    func fetch<T: Object>(model: T.Type, predicate: NSPredicate? = nil, sorted: Sort? = nil) throws -> Results<T> {
        return try Object.fetch(model: model, predicate: predicate, sorted: sorted)
    }
    
    static func fetch<T: Object>(model: T.Type, predicate: NSPredicate? = nil, sorted: Sort? = nil) throws -> Results<T> {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        var objects = realm.objects(model)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        return objects
    }
    
    func fetch<T: Object>(model: T.Type, predicate: NSPredicate? = nil, sorted: Sort? = nil, completion: @escaping(_ objects: Results<T>) -> Void) throws {
        guard let realm = realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        DispatchQueue.global(qos: .background).async {
            var objects = realm.objects(model)
            
            if let predicate = predicate {
                objects = objects.filter(predicate)
            }
            
            if let sorted = sorted {
                objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
            }
        
            completion(objects)
        }
    }
    
    
    func fetchFirst<T: Object>(model: T.Type, predicate: NSPredicate? = nil, sorted: Sort? = nil) throws -> T? {
        return try self.fetch(model: model, predicate: predicate, sorted: sorted).first
    }
    
    func fetchFirst<T: Object>(model: T.Type, predicate: NSPredicate? = nil, sorted: Sort? = nil, completion: @escaping(_ objects: T?) -> Void) throws {
        try self.fetch(model: model, predicate: predicate, sorted: sorted, completion: { (objects) in
            completion(objects.first)
        })
    }
}
