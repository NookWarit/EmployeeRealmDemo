import UIKit
import RealmSwift

class AddEmployeeViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var interactor: AddEmployeeBusinessLogic?
    var router: (NSObjectProtocol & AddEmployeeRoutingLogic & AddEmployeeDataPassing)?
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
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: Do something
    
    func clearTextField() {
        nameTextField.text = ""
        positionTextField.text = ""
        salaryTextField.text = ""
        ageTextField.text = ""
        phoneNumTextField.text = ""
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
   
    @IBAction func addAction(_ sender: Any) {
        if(nameTextField.text != "" && positionTextField.text != "" && salaryTextField.text != "" && ageTextField.text != "" && phoneNumTextField.text != "") {
            interactor?.insertData(request: AddEmployee.InsertData.Request(name: nameTextField.text ?? "",
                                                                           position: positionTextField.text ?? "",
                                                                           salary: Int(salaryTextField.text ?? "") ?? 0,
                                                                           age: Int(ageTextField.text ?? "") ?? 0,
                                                                           phoneNumber:  phoneNumTextField.text ?? "",
                                                                           image: profileImage.image ?? UIImage()))
            clearTextField()
            router?.popViewController()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        router?.popViewController()
    }
}

//MARK: Setup & Configuration
extension AddEmployeeViewController {
    private func setup() {
        
    }
    
    private func configure() {
        AddEmployeeConfiguration.shared.configure(self)
    }
}

extension AddEmployeeViewController : AddEmployeeDisplayLogic {
    func displayInSertData(viewModel: AddEmployee.InsertData.ViewModel) {
        
    }
}

extension AddEmployeeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddEmployeeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
