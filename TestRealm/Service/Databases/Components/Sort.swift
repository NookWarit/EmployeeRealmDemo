import Foundation

@objc public class Sort: NSObject {
    public var key: String
    public var ascending: Bool
    
    override public init() {
        key = ""
        ascending = false
        
        super.init()
    }
}
