import UIKit
import RealmSwift

class EmployeeViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var interactor: EmployeeBusinessLogic?
    var router: (NSObjectProtocol & EmployeeRoutingLogic & EmployeeDataPassing)?
    var employeeModel = [EmployeeModel]()
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for cell in Employee.Section.allCases {
            tableView.register(UINib(nibName: cell.cell, bundle: nil),
                               forCellReuseIdentifier: cell.cell)
        }
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        searchbar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employeeModel = EmployeeModel.fetch()
        tableView.reloadData()
    }
    
    // MARK: Do something
    @IBAction func addAction(_ sender: Any) {
        router?.routeToAddEmployee()
    }
    
}

//MARK: Setup & Configuration
extension EmployeeViewController {
    private func setup() {
        
    }
    
    private func configure() {
        EmployeeConfiguration.shared.configure(self)
    }
}

extension EmployeeViewController : EmployeeDisplayLogic {
    func displayDeleteData(viewModel: Employee.DeleteData.ViewModel) {
        employeeModel = viewModel.data
        tableView.reloadData()
    }
    
    func displaySearchData(viewModel: Employee.SearchData.ViewModel) {
        employeeModel = viewModel.data
        tableView.reloadData()
    }
}

extension EmployeeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Employee.Section.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = Employee.Section(rawValue: section) {
            switch section {
            case .header:
                return 1
            case .row:
                return employeeModel.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = Employee.Section(rawValue: indexPath.section) {
            let cell = tableView.dequeueReusableCell(withIdentifier: section.cell, for: indexPath)
            switch section {
            case .header:
                let headerCell = cell as? EmployeeTableViewCell
                headerCell?.header()
                return headerCell ?? UITableViewCell()
            case .row:
                let rowCell = cell as? EmployeeTableViewCell
                rowCell?.configureCell(employeeModel: employeeModel[indexPath.row])
                return rowCell ?? UITableViewCell()
            }}
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let section = Employee.Section(rawValue: indexPath.section) {
//            switch section {
//            case .header:
//                return tableView.layer.bounds.width * 0.05
//            case .row:
//                return UITableView.automaticDimension
//            }
//        }
        return UITableView.automaticDimension
    }
}

extension EmployeeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.searchData(request: Employee.SearchData.Request(searchText: searchText))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchbar.becomeFirstResponder()
    }
    
    
}

extension EmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            interactor?.deleteData(request: Employee.DeleteData.Request(id: employeeModel[indexPath.row].id))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToEditEmployee(employeeData: employeeModel[indexPath.row])
    }
}
