//
//  PrepMapContentCell.swift
//  CTCI
//
//  Created by Michael Odere on 10/30/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapContentCell:UICollectionViewCell{
   
    @IBOutlet var view: PrepMapView!

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = false

    }
    
    func daysText(days:Int)->String{
        if days == 1{
            return "\(days) day"
        }else{
            return "\(days) days"
        }
    }
    
    func cellColor(days: Int, runningDays: Int, currentDaysFromSelectedDate: Int)->UIColor{
        
        var color = UIColor.red
        
        if runningDays <= currentDaysFromSelectedDate{
            if runningDays + days >= currentDaysFromSelectedDate{
                color = UIColor.blue
                
            }else{
               color = UIColor.green
            }
        }
        
        return color
    }
}


