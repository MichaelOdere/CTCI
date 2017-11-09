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
    var lastFrame:CGRect!
    var isAnimating = false
    
    var currentSelectedDate:Date!
    var currentDaysFromSelectedDate = 50000
    var runningDays:Int = 0
    
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
                    print("Should reload")
                    collectionView.reloadData()
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
            print("curre ddays", currentDaysFromSelectedDate)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isAnArrow(index: indexPath.item ) || isAnimating{
            return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        isAnimating = true
        
        var popUpView = UIView(frame: cell.layer.frame)
        self.view.addSubview(popUpView)
        UIView.animate(withDuration: 0.2, animations: {
            
            let isShowing:Bool = cell.frame == collectionView.bounds ? true : false
            
            if isShowing{
                collectionView.isScrollEnabled = true
                collectionView.reloadItems(at: [indexPath])
            }else{
                cell.layer.cornerRadius = 0

                self.lastFrame = cell.frame
                cell.frame = collectionView.bounds
                collectionView.isScrollEnabled = false
                cell.superview?.bringSubview(toFront: cell)
            }

            
        },completion:{ (finished: Bool) in
            self.isAnimating = false
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0{
            runningDays = 0
        }
        
        var days = 60
        if isAnArrow(index: indexPath.item){
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            cell.arrowImage.image = getImage(index: indexPath.item)
            return cell

        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! PrepMapContentCell
            
            cell.title.text = String(test[indexPath.row])
            
            if days > 1{
                cell.duration.text = " \(days) days"
            }else{
                cell.duration.text = " \(days) day"
            }
            
            cell.descriptionText.text = "this is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is llthis is ll"
            
            cell.sizeToFit()
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowOffset = CGSize.zero
            cell.layer.shadowRadius = 10
            cell.layer.masksToBounds = false
            cell.layer.shouldRasterize = true
            if runningDays < currentDaysFromSelectedDate{
                if runningDays + days >= currentDaysFromSelectedDate{
                    cell.backgroundColor = UIColor.blue

                }else{
                    cell.backgroundColor = UIColor.green
                }
            }else{
                cell.backgroundColor = UIColor.red
            }
//            print(runningDays)
            runningDays += days
            return cell

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
}
 
