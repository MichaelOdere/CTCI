//
//  MapViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/26/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet var mapScrollView: UIScrollView!
    @IBOutlet var mapScrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var progressLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var progressLabel: UILabel!
    
    let dateButton = UIButton(frame: CGRect(x: 0, y: 10, width: 100, height: 50))
    var dateButtonTop : NSLayoutConstraint?
    var dateButtonCenterX : NSLayoutConstraint?
    
    var margins:UILayoutGuide!

    var progressY:CGFloat = 0
    var theDate:Date!
    
    override func viewDidLoad() {
   
        
//        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "myStartDate")
        
        
    }
    

    
    //     Update the view if the date has been changed
    override func viewDidAppear(_ animated: Bool) {

        updateView()
    }

    func updateView(){
        
        let defaults = UserDefaults.standard
        let selectedDate = defaults.object(forKey: "myStartDate")
        
        // If the user has a preset selected date
        if selectedDate != nil{
            // Update the offset to match the date value so that the user will be automatically
            // scrolled to their position
            updateProgressY(selectedDate: selectedDate as! Date)

            progressLabel.text = "This is Your Current Progress"
            mapScrollView.isScrollEnabled = true
            
            // In the case the user has updated their date
            if theDate != selectedDate as? Date{
                theDate = selectedDate as? Date

                // Update the scroll and other things that need to be offset
               setOffsets()
                
                progressLabel.alpha = 1
                progressLabel.textAlignment = .center
                mapScrollView.backgroundColor = UIColor.clear
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()

                }
                
                UIView.animate(withDuration: 1.0,
                               delay: 4.0,
                               options: [],
                               animations:{
                                    self.progressLabel.alpha = 0
                                },
                               completion: nil)
               
            }
        }else{
         
            progressLabel.text = "Please Select a Date Before Continuing!"
            mapScrollView.isScrollEnabled = false
            mapScrollView.backgroundColor = UIColor.gray
        }
        
    }
    
    func updateProgressY(selectedDate: Date){
        let calendar = NSCalendar.current
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        // Replace the hour (time) of both dates with 00:00
        let currentDate = calendar.startOfDay(for: Date())
        let userDate = calendar.startOfDay(for: selectedDate)
        
        let components = calendar.dateComponents([.day], from: userDate, to: currentDate)
        
        var day = components.day!
        
        // We don't want values greater than 365 and less than 0
        if day > 365{
            day = 365
        }else if day < 0{
            day = 0
        }
        
        progressY = CGFloat(day) / 365.0
    }
    
    func setOffsets(){
        let newLevel = (mapScrollView.contentSize.height - mapScrollView.frame.height + mapScrollView.frame.origin.y) * progressY
        self.mapScrollView.setContentOffset(CGPoint(x: 0.0,y: newLevel), animated: true)
        self.progressLabelTopConstraint.constant = newLevel
    }
    
}
