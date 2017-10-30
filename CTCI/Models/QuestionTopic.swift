//
//  QuestionTopic.swift
//  CTCI
//
//  Created by Michael Odere on 10/22/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import Foundation

class QuestionTopic: Topic{
    
    var questions: [Question]
    
    init(name: String, imageName: String, questions: [Question]) {
        self.questions = questions
       
        super.init(name: name, imageName: imageName)

    }
    
}
