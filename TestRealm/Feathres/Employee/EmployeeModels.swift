import UIKit

enum Employee {
    enum Section: Int, CaseIterable {
        case header = 0
        case row
        
        static var numberOfSections: Int { return self.allCases.count }
        var cell: String {
            switch self {
            case .header:
                return "EmployeeTableViewCell"
            case .row:
                return "EmployeeTableViewCell"
            }
        }
    }
    
    enum SearchData {
        struct Request{
            var searchText: String
        }
        struct Response{
            var data: [EmployeeModel]
        }
        struct ViewModel{
            var data: [EmployeeModel]
        }
    }
    
    enum DeleteData {
        struct Request{
            var id: Int
        }
        struct Response{
            var data: [EmployeeModel]
        }
        struct ViewModel{
            var data: [EmployeeModel]
        }
    }
}
