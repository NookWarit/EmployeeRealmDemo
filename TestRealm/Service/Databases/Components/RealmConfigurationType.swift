import Foundation

public enum RealmConfigurationType {
    case general(url: String?)
    case inMemory(identifier: String?)

    var associated: String? {
        switch self {
        case .general(let url): return url
        case .inMemory(let identifier): return identifier
        }
    }
}
