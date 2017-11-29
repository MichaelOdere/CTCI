import UIKit

class PrepMapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var milestoneStore:MilestoneStore!
    var popUpView:PrepMapView!
    var lastCell:PrepMapContentCell!
    
    var isAnimating = false
    var hasInitialized = false
    
    var currentSelectedDate:Date!
    var currentDaysFromSelectedDate = 50000
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        initializeDates()
        initializePopUpView()
        
        milestoneStore = MilestoneStore()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        collectionView.backgroundColor = UIColor(red:169/255, green:183/255, blue:192/255, alpha:1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeDates()
        if !hasInitialized{
            self.reloadAnimation()
            hasInitialized = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return milestoneStore.prepMap.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if milestoneStore.isAnArrow(index: indexPath.item ) || isAnimating{
            return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? PrepMapContentCell else { return }
        addPopUpView(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if milestoneStore.isAnArrow(index: indexPath.item){
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            cell.arrowImage.image = cell.getImage(index: indexPath.item)
            return cell

        }else{

            let milestone = milestoneStore.prepMap[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! PrepMapContentCell
            let cellView:PrepMapView = cell.view
            cellView.title.text = milestone.title
            cellView.duration.text = String(milestone.days)
            cellView.descriptionText.text = milestone.desc
            cellView.backgroundColor = milestoneStore.cellColor(milestone: milestone, currentDaysFromSelectedDate: currentDaysFromSelectedDate)
            
            return cell
        }
    }
    
    func reloadAnimation(){
        var delay:Double = 0.0
        var paths = collectionView.indexPathsForVisibleItems
        paths = paths.sorted(by: {$0.row < $1.row})
        for indexPath in paths{

            if let cell = collectionView.cellForItem(at: indexPath) as? PrepMapContentCell{
                cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                let tempColor = cell.view.backgroundColor
                cell.view.backgroundColor = UIColor.red

                UIView.animate(withDuration: 0.3, delay: 0.05 * delay, options: .curveEaseIn, animations: {
                    cell.view.backgroundColor = tempColor
                    cell.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
                    cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                })

                delay += 1
            }
        }
    }

    @objc func removePopUp(sender: UITapGestureRecognizer? = nil) {
        self.isAnimating = true

        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame = (self.lastCell.superview?.convert(self.lastCell.frame, to: self.view))!
            self.popUpView.layer.cornerRadius = 15
            self.view.layoutIfNeeded()

        },completion:{ (finished: Bool) in
            self.isAnimating = false
            self.popUpView.removeFromSuperview()
            print("self.popUpView.title.frame111")
            print(self.popUpView.title.frame)

        })
    }
    
    func addPopUpView(cell: PrepMapContentCell){
        if isAnimating{
            return
        }
        isAnimating = true
        
        self.lastCell =  cell
        popUpView.frame = (self.lastCell.superview?.convert(cell.frame, to: self.view))!
        popUpView.backgroundColor = cell.view.backgroundColor
        
        let cellView:PrepMapView = cell.view

        popUpView.title.text = cellView.title.text
        popUpView.descriptionText.text = cellView.descriptionText.text
        popUpView.duration.text = cellView.duration.text
        self.view.addSubview(popUpView)

        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame = self.collectionView.frame
            self.popUpView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
            
        },completion:{ (finished: Bool) in
            self.isAnimating = false
        })
    }
    
    func initializeDates(){
        let defaults = UserDefaults.standard
        let tempDate = defaults.object(forKey: "myStartDate")
        
        if tempDate != nil{
            if currentSelectedDate != nil{
                if currentSelectedDate != tempDate as? Date{
                    
                    self.collectionView.reloadData{
                        self.reloadAnimation()
                    }
                    
                }
            }
            currentSelectedDate =  tempDate as! Date
            
            let calendar = NSCalendar.current
            
            let date1 = calendar.startOfDay(for: currentSelectedDate)
            let date2 = calendar.startOfDay(for: Date())
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if components.day! < 0{
                currentDaysFromSelectedDate = 0
                
            }else{
                currentDaysFromSelectedDate = components.day!
            }
        }
    }
    
    func initializePopUpView(){
      
        // Frames
        popUpView = PrepMapView(frame: CGRect(x: 0, y: 0, width: 75, height: 100))
        popUpView.title = UILabel(frame: CGRect(x: 10, y: 0, width: 54, height: 27))
        popUpView.descriptionText = UILabel(frame: CGRect(x: 0, y: 34, width:75, height: 44))
        popUpView.duration = UILabel(frame: CGRect(x: 30, y: 86, width: 43, height: 12))

        popUpView.addSubview(popUpView.title)
        popUpView.addSubview(popUpView.descriptionText)
        popUpView.addSubview(popUpView.duration)

        // Descriptioin label atributes
        popUpView.descriptionText.textAlignment = .center
        popUpView.descriptionText.numberOfLines = 8

        // Need to turn off autoresizing
        popUpView.title.translatesAutoresizingMaskIntoConstraints = false
        popUpView.descriptionText.translatesAutoresizingMaskIntoConstraints = false
        popUpView.duration.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        let titleCenterX = NSLayoutConstraint(item: popUpView.title, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        titleCenterX.isActive = true

        let titleTop = NSLayoutConstraint(item: popUpView.title, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        titleTop.isActive = true
       
        let descriptionTextTop = NSLayoutConstraint(item: popUpView.descriptionText, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: popUpView.title, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 6)
        descriptionTextTop.isActive = true
        
        let descriptionTextBottom = NSLayoutConstraint(item: popUpView.descriptionText, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: popUpView.duration, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -6)
        descriptionTextBottom.isActive = true

        let descriptionTextLeading = NSLayoutConstraint(item: popUpView.descriptionText, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        descriptionTextLeading.isActive = true
        
        let descriptionTextTrailing = NSLayoutConstraint(item: popUpView.descriptionText, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        descriptionTextTrailing.isActive = true
        
        let durationBottom = NSLayoutConstraint(item: popUpView.duration, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -2)
        durationBottom.isActive = true
        
        let durationRight = NSLayoutConstraint(item: popUpView.duration, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -6)
        durationRight.isActive = true
        
        // Stretch priorityies
        popUpView.title.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        popUpView.descriptionText.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        popUpView.duration.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)

        popUpView.title.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        popUpView.descriptionText.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
        popUpView.duration.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)

        // Font Sizes
        self.popUpView.title.font = self.popUpView.title.font.withSize(22)
        self.popUpView.descriptionText.font = self.popUpView.descriptionText.font.withSize(14.0)
        self.popUpView.duration.font = self.popUpView.duration.font.withSize(10.0)

        // Tap gesture to remove popupview
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.removePopUp(sender:)))
        popUpView.addGestureRecognizer(tapGestureRecognizer)
    }

}

extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
