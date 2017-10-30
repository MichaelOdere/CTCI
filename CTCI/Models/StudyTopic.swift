//
//  StudyTopic.swift
//  CTCI
//
//  Created by Michael Odere on 10/21/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

class StudyTopic: Topic {
    
    var notes : [Note]
    
    init(name: String, imageName: String, notes:[Note]) {
        self.notes = notes
        super.init(name: name, imageName: imageName)
    }
}
