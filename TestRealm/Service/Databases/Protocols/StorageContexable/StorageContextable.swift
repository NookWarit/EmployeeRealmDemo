import Foundation
import RealmSwift

//MARK: Configuration
public extension Object {
    var realm: Realm? {
        return Object.realm
    }
    
    static var realm: Realm? {
        let url = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString
        
        if let realm = try? configure(configuration: .general(url: url)) {
            return realm
        }
        
        return try! Realm()
    }
}
