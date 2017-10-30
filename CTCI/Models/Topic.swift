//
//  Topic.swift
//  CTCI
//
//  Created by Michael Odere on 10/15/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import Foundation

class Topic: NSObject {
    
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
       
    }
}
