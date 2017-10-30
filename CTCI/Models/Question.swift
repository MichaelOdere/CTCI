//
//  Question.swift
//  CTCI
//
//  Created by Michael Odere on 10/22/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import Foundation

class Question: NSObject {
    var question          : String
    var answer            : String
    var codeImageName     : String
    var hint              : String
    var complexity        : String
    
    init(question: String, answer: String, codeImageName: String, hint: String, complexity: String) {
        self.question = question
        self.answer = answer
        self.codeImageName = codeImageName
        self.hint = hint
        self.complexity = complexity
        
        
    }
    
}
