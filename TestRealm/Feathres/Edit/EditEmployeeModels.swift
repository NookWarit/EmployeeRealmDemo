import UIKit

enum EditEmployee {    
    enum UpdateData {
        struct Request{
            var id: Int
            var name: String
            var position: String
            var salary: Int
            var age: Int
            var phoneNumber: String
            var image: UIImage
        }
        struct Response{

        }
        struct ViewModel{

        }
    }
}
