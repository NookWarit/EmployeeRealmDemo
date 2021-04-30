import UIKit

class EmployeeTableViewCell: UITableViewCell {
// MARK: IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(employeeModel: EmployeeModel) {
        nameLabel.text = employeeModel.name
        positionLabel.text = employeeModel.position
        salaryLabel.text = "\(employeeModel.salary)"
        ageLabel.text = "\(employeeModel.age)"
        phoneNumberLabel.text = employeeModel.phoneNumber
    }
    
    func header() {
        nameLabel.text = "NAME"
        positionLabel.text = "POSITION"
        salaryLabel.text = "SALARY"
        ageLabel.text = "AGE"
        phoneNumberLabel.text = "PHONE NUMBER"
        self.backgroundColor = .cyan
    }
}
