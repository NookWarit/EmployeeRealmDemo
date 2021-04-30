import UIKit

class EditEmployeeViewController: UIViewController {
    // MARK: @IBOutlet

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var interactor: EditEmployeeBusinessLogic?
    var router: (NSObjectProtocol & EditEmployeeRoutingLogic & EditEmployeeDataPassing)?
    var employeeModel = [EmployeeModel]()
    var employeeData = EmployeeModel()
    var pickerController = UIImagePickerController()
    
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
        nameTextField.text = employeeData.name
        positionTextField.text = employeeData.position
        salaryTextField.text = "\(employeeData.salary)"
        ageTextField.text = "\(employeeData.age)"
        phoneNumTextField.text = employeeData.phoneNumber
        profileImage.image = employeeData.image
    }
    
    // MARK: Do something

    @IBAction func saveAction(_ sender: Any) {
        interactor?.updateData(request: EditEmployee.UpdateData.Request(id: employeeData.id,
                                                                        name: nameTextField.text ?? "",
                                                                        position: positionTextField.text ?? "",
                                                                        salary: Int(salaryTextField.text ?? "") ?? 0,
                                                                        age: Int(ageTextField.text ?? "") ?? 0,
                                                                        phoneNumber: phoneNumTextField.text ?? "",
                                                                        image: profileImage.image ?? UIImage()))
        router?.popViewController()
        
    }
    
    @IBAction func openGallaryAction() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            pickerController.modalPresentationStyle = .formSheet
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        router?.popViewController()
    }
    
    @IBAction func deleteAction(_ sender: Any?) {
        EmployeeModel.removeEmployee(id: employeeData.id)
        router?.popViewController()
    }
}

//MARK: Setup & Configuration
extension EditEmployeeViewController {
    private func setup() {
        
    }
    
    private func configure() {
        EditEmployeeConfiguration.shared.configure(self)
    }
}

extension EditEmployeeViewController : EditEmployeeDisplayLogic {
    
}

extension EditEmployeeViewController: UITextFieldDelegate {
    
}

// MARK: - UIImagePickerControllerDelegate
extension EditEmployeeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let possibleImage = info[.editedImage] as? UIImage {

            profileImage.image = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            profileImage.image = possibleImage
        } else {
            return
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
}

