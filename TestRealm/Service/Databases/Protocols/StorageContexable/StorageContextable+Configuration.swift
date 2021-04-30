import Foundation
import RealmSwift

//MARK: Initial realm configuration
extension Object {
    func configure(configuration: RealmConfigurationType = .general(url: nil)) throws -> Realm? {
        return try Object.configure(configuration: configuration)
    }
    
    static func configure(configuration: RealmConfigurationType = .general(url: nil)) throws -> Realm? {
        return try DatabaseManager.default.configure(configuration: configuration)
    }
}
