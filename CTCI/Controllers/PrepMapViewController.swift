import UIKit

class PrepMapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    var milestoneStore:MilestoneStore!
    var popUpView:PrepMapView!
    var lastFrame:CGRect!
    var isAnimating = false
    var hasInitialized = false
    let scaler = 20
    
    var currentSelectedDate:Date!
    var currentDaysFromSelectedDate = 50000
    
    var titleTop:NSLayoutConstraint!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        let temp = defaults.object(forKey: "myStartDate")
        
        if temp != nil{
            currentSelectedDate =  temp as! Date

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
        
        initializePopUpView()
        milestoneStore = MilestoneStore()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
//        collectionView.backgroundColor = UIColor(red:169/255, green:183/255, blue:192/255, alpha:1.0)


    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let temp = defaults.object(forKey: "myStartDate")
        
        if temp != nil{
            if currentSelectedDate != nil{
                if currentSelectedDate != temp as? Date{

                    self.collectionView.reloadData{
                        self.reloadAnimation()
                    }
                    
//                    self.updateCollectionViewColors {
//                        print("Done!")
//                    }
                }
            }
            currentSelectedDate =  temp as! Date

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
            let cellView = cell.view as! PrepMapView
            cellView.title.text = milestone.title
            cellView.duration.text = String(milestone.days)
            cellView.descriptionText.text = milestone.desc

            cellView.backgroundColor = milestoneStore.cellColor(milestone: milestone, currentDaysFromSelectedDate: currentDaysFromSelectedDate)
            
            return cell

        }
        
    }
    
    func reloadAnimation(){
        print("animating....")
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

//        self.popUpView.title.font =  self.popUpView.title.font.withSize(20)
        let labelCopy = self.popUpView.title.copyLabel()
        var smallerBounds = labelCopy.bounds
        labelCopy.font = self.popUpView.title.font.withSize(22)
        smallerBounds.size = labelCopy.intrinsicContentSize
        
        let shrinkTransform = scaleTransform(from: self.popUpView.title.bounds.size, to: smallerBounds.size)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            print("12222222")
            print(self.popUpView.title.frame)
            self.popUpView.frame = self.lastFrame
//            self.popUpView.title.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.popUpView.title.transform = shrinkTransform

//            self.popUpView.title.font = self.popUpView.title.font.withSize(22)
//            self.popUpView.title.transform =  .identity //CGAffineTransform(scaleX: CGFloat(1/self.scaler), y: CGFloat(1/self.scaler))

            self.titleTop.constant = -50

            self.popUpView.layer.cornerRadius = 15
            self.view.layoutIfNeeded()

        },completion:{ (finished: Bool) in
            self.popUpView.title.font = labelCopy.font
            self.popUpView.title.transform = .identity
            self.popUpView.title.bounds = smallerBounds
            self.isAnimating = false
            self.popUpView.removeFromSuperview()
        })
    }
    
    func addPopUpView(cell: PrepMapContentCell){
        if isAnimating{
            return
        }
        isAnimating = true
        
        lastFrame =  cell.superview?.convert(cell.frame, to: self.view)
        popUpView.frame = lastFrame
        popUpView.backgroundColor = cell.view.backgroundColor
        
        let cellView = cell.view as! PrepMapView
        popUpView.title.text = cellView.title.text
        popUpView.descriptionText.text = cellView.descriptionText.text
        popUpView.duration.text = cellView.duration.text
        print("popUpView.title.frame")
        print(popUpView.title.frame)
        self.view.addSubview(popUpView)
        
        var biggerBounds = popUpView.title.bounds
        popUpView.title.font = popUpView.title.font.withSize(100)
        biggerBounds.size = popUpView.title.intrinsicContentSize
        
        popUpView.title.transform = scaleTransform(from: biggerBounds.size, to: popUpView.title.bounds.size)
        popUpView.title.bounds = biggerBounds
        print("123333")
        print(popUpView.title.frame)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame = self.collectionView.frame
            self.popUpView.title.transform = .identity

            self.titleTop.constant = 0

            self.popUpView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
            
        },completion:{ (finished: Bool) in
            self.isAnimating = false
        })
        
    }
    
    func initializePopUpView(){

        popUpView = PrepMapView(frame: CGRect(x: 0, y: 0, width: 75, height: 100))
        popUpView.title = UILabel(frame: CGRect(x: 10, y: 0, width: 1 * 54, height: 1 * 27))
        popUpView.title.backgroundColor = UIColor.purple
        popUpView.title.font = popUpView.title.font.withSize(CGFloat(22 * 1))

        let descriptionText = UILabel(frame: CGRect(x: 0, y: 34, width:75, height: 44))
        let duration = UILabel(frame: CGRect(x: 30, y: 86, width: 43, height: 12))
    
        descriptionText.numberOfLines = 8
        print("dddd")
        print(popUpView.title.frame)
        popUpView.addSubview(popUpView.title)
        popUpView.addSubview(descriptionText)
        popUpView.addSubview(duration)
       
        print("sadfjlk")
        print(popUpView.title.frame)
        popUpView.title.translatesAutoresizingMaskIntoConstraints = false
//        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false

        let titleCenterX = NSLayoutConstraint(item: popUpView.title, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        titleCenterX.isActive = true
        
        titleTop = NSLayoutConstraint(item: popUpView.title, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: popUpView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        titleTop.isActive = true
//
        let durationBottom = NSLayoutConstraint(item: duration, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -2)
        durationBottom.isActive = true
        let durationRight = NSLayoutConstraint(item: duration, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -2)
        durationRight.isActive = true

        popUpView.descriptionText = descriptionText
        popUpView.duration = duration
        self.popUpView.frame = self.collectionView.frame

//        self.popUpView.title.font = self.popUpView.title.font.withSize(22.0)
        self.popUpView.descriptionText.font = self.popUpView.descriptionText.font.withSize(14.0)
        self.popUpView.duration.font = self.popUpView.duration.font.withSize(10.0)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.removePopUp(sender:)))
        popUpView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func scaleTransform(from: CGSize, to: CGSize) -> CGAffineTransform {
        let scaleX = to.width / from.width
        let scaleY = to.height / from.height
        
        return CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
}


extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

extension UILabel {
    func copyLabel() -> UILabel {
        let label = UILabel()
        label.font = self.font
        label.frame = self.frame
        label.text = self.text
        return label
    }
}

