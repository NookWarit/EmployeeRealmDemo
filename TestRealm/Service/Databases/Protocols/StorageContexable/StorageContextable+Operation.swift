import Foundation
import RealmSwift

//MARK: Operation Write
public extension Object {
    func write(_ block: (() throws -> Void)) throws {
        guard let realm = self.realm else {
            throw RealmErrorType.realmIsEmpty
        }
        
        if realm.isInWriteTransaction {
            try block()
        }
        else {
            try realm.write(block)
        }
    }
}
