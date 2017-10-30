//
//  Note.swift
//  CTCI
//
//  Created by Michael Odere on 10/21/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//
import Foundation
class Note: NSObject {
    var title: String
    var bullets: [String]
    
    init(title: String, bullets: [String]) {
        self.title = title
        self.bullets = bullets
        
    }
    
    func getBullets()-> String{
        
        var bulletsFormat = ""
        for b in bullets{
            bulletsFormat.append("\u{2022}  ")
            bulletsFormat.append(b)
            bulletsFormat.append("\n")

        }
        
        return bulletsFormat
    }
}
