//
//  PrepMapView.swift
//  CTCI
//
//  Created by Michael Odere on 11/9/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapView: UIView {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var descriptionText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        self.layer.cornerRadius = 15
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
    }

}


