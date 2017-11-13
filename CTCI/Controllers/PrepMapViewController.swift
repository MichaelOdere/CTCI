//
//  MapViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/26/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    let test = Array(0...29)
    var popUpView:PrepMapView!
    var lastFrame:CGRect!
    var isAnimating = false
    var hasInitialized = false

    var currentSelectedDate:Date!
    var currentDaysFromSelectedDate = 50000
    var runningDays:Int = 0
    
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let temp = defaults.object(forKey: "myStartDate")
        
        if temp != nil{
            if currentSelectedDate != nil{
                if currentSelectedDate != temp as? Date{
                    collectionView.reloadData{
                        self.reloadAnimation()
                    }
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
        return test.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        
        if isAnArrow(index: indexPath.item ) || isAnimating{
            return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? PrepMapContentCell else { return }
        addPopUpView(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        print(indexPath.row)
        if indexPath.row == 0{
            runningDays = 0
        }
        
        let days = 60
        if isAnArrow(index: indexPath.item){
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            cell.arrowImage.image = getImage(index: indexPath.item)
            return cell

        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! PrepMapContentCell
            let cellView = cell.view as! PrepMapView
            cellView.title.text = String(test[indexPath.row])
            
            if days > 1{
                cellView.duration.text = " \(days) days"
            }else{
                cellView.duration.text = " \(days) day"
            }
            
            cellView.descriptionText.text = "this is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is ll"
            
            cell.sizeToFit()
            cell.layer.cornerRadius = 15
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize.zero
            cell.layer.shadowRadius = 10
            cell.layer.masksToBounds = true
            cell.layer.shouldRasterize = true
            
            print("runningDays \(runningDays)")
            print("currentDaysFromSelectedDate \(currentDaysFromSelectedDate)")
            print("days \(days)")

            if runningDays < currentDaysFromSelectedDate{
                if runningDays + days >= currentDaysFromSelectedDate{
                    cellView.backgroundColor = UIColor.blue

                }else{
                    cellView.backgroundColor = UIColor.green
                }
            }else{
                cellView.backgroundColor = UIColor.red
            }
            runningDays += days
            
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
                cell.view.backgroundColor = UIColor.red

                UIView.animate(withDuration: 0.3, delay: 0.05 * delay, options: .curveEaseIn, animations: {
                    cell.view.backgroundColor = UIColor.green
                    cell.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
                    cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                })

                delay += 1
            }
        }
    }
    
    // C = Content
    // A = Arrow
    // [C, A, C, A, C, A, A, C, A, C, A, C, A, A]
    
    // This function returns the (A)rrow index's
    func isAnArrow(index: Int)->Bool{
        if (index % 7) % 2 == 1 || index % 7 == 6{
            return true
        }
        
        return false
    }
    
    // There are 3 Image directions (Right, Left, Down) and one nil case to decipher
    // nil is used for no image
    // [C, right, C, right, C, Down, nil, C, Left, C, Left, C, nil, Down]
    // Returns the correct IMage
    func getImage(index: Int)->UIImage?{
        let mod_7 = index % 7
        let mod_14 = index % 14
        let isLeft = mod_14 > 7
        
        // Right Case
        var img = UIImage(named: "arrow")

        // Down or Nil Case
        if mod_7 >= 5{
            // If it is the 5th spot AND the direction is right OR if it is the 6th spot AND the direction is left
            if mod_7 == 5 && !isLeft ||  mod_7 == 6 && isLeft{
                img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .right)
            }
            // Opposite of the cases above
            else{
                img = nil
            }
        }
            
        // Left Case
        else if isLeft{
            img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .down)
        }
        
        return img
    }
    
    @objc func removePopUp(sender: UITapGestureRecognizer? = nil) {
        self.isAnimating = true

        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame = self.lastFrame
            self.popUpView.title.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            self.titleTop.constant = 0

            self.popUpView.layer.cornerRadius = 15
            self.view.layoutIfNeeded()

        },completion:{ (finished: Bool) in
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
        
        self.view.addSubview(popUpView)
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.frame = self.collectionView.frame
//            self.popUpView.title.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            self.popUpView.title.bounds = CGRect(x: 0, y: 0, width: cellView.title.frame.width * 3, height: cellView.title.frame.height * 3)
            self.popUpView.title.font = self.popUpView.title.font.withSize(100)
            self.titleTop.constant = 0
            
            self.popUpView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
            
        },completion:{ (finished: Bool) in
            self.isAnimating = false
        })
        
    }
    
    func initializePopUpView(){
        
        popUpView = PrepMapView(frame: CGRect(x: 0, y: 0, width: 75, height: 100))
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: 54, height: 27))
        let descriptionText = UILabel(frame: CGRect(x: 0, y: 34, width:75, height: 44))
        let duration = UILabel(frame: CGRect(x: 30, y: 86, width: 43, height: 12))
    
        descriptionText.numberOfLines = 8
        
        popUpView.addSubview(title)
        popUpView.addSubview(descriptionText)
        popUpView.addSubview(duration)
       
        title.translatesAutoresizingMaskIntoConstraints = false
//        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        duration.translatesAutoresizingMaskIntoConstraints = false

        let titleCenterX = NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        titleCenterX.isActive = true
        
        titleTop = NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: popUpView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        titleTop.isActive = true
//
        let durationBottom = NSLayoutConstraint(item: duration, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -2)
        durationBottom.isActive = true
        let durationRight = NSLayoutConstraint(item: duration, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: popUpView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -2)
        durationRight.isActive = true

        popUpView.title = title
        popUpView.descriptionText = descriptionText
        popUpView.duration = duration
        self.popUpView.frame = self.collectionView.frame

        self.popUpView.title.font = self.popUpView.title.font.withSize(22.0)
        self.popUpView.descriptionText.font = self.popUpView.descriptionText.font.withSize(14.0)
        self.popUpView.duration.font = self.popUpView.duration.font.withSize(10.0)

        popUpView.layer.cornerRadius = 15
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOpacity = 1
        popUpView.layer.shadowOffset = CGSize.zero
        popUpView.layer.shadowRadius = 10
        popUpView.layer.masksToBounds = true

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
/*

func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    let opactiyAnimation = CABasicAnimation(keyPath: "cornerRadius")
    opactiyAnimation.fromValue = 15
    cell.layer.cornerRadius = 15
    opactiyAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    opactiyAnimation.toValue = 10
    opactiyAnimation.duration = 10
    cell.layer.add(opactiyAnimation, forKey: opactiyAnimation.keyPath)
    print(indexPath.row)
}


 */
