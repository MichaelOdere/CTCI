import UIKit

class MyDateViewController: UIViewController{
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var currentDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd, MMMM yyyy"

        var dateAsString = "no"
        
        let defaults = UserDefaults.standard
        let selectedDate = defaults.object(forKey: "myStartDate")
        
        if selectedDate != nil{
            dateAsString = formatter.string(from: selectedDate as! Date)
             datePicker.date = selectedDate as! Date

        }
        
        currentDateLabel.text = "You currently have \(dateAsString) selected for your start date"
                datePicker.datePickerMode = UIDatePickerMode.date
        
    }
    
    @IBAction func saveBarButton(_ sender: Any) {
        saveDate()
        self.dismiss(animated: true, completion: nil)
        
    }
 
    @IBAction func cancelBarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
   
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
 
    }
    
    func saveDate() {
        let defaults = UserDefaults.standard
        defaults.set(datePicker.date, forKey: "myStartDate")
        
    }
    
}
