//
//  MainTopicStore.swift
//  CTCI
//
//  Created by Michael Odere on 10/15/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

class StudyStore {
    
    var allStudyTopics = [StudyTopic]()
    
    init() {
        var notes: [Note] = []
        var topic: StudyTopic!
        
        notes.append(Note(title: "Definition",
                         bullets: ["Big O is used to describe computer complextiy of an algorithm",
                                   "Good algorithms run in lower Big O complexity"]))
        notes.append(Note(title: "Big O",
                          bullets: ["Big O is used to describe computer complextiy of an algorithm",
                                    "Good algorithms run in lower Big O complexity"]))
        topic = StudyTopic(name: "Big O", imageName: "Intro.png", notes: notes)
        allStudyTopics.append(topic)
        
        notes.removeAll()
        
        notes.append(Note(title: "Before the Interview",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm",
                                    "Good algorithms run in lower Big O complexity"]))
        notes.append(Note(title: "4 O",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm",
                                    "2 algorithms run in lower Big O complexity",
                                    "3 algorithms run in lower Big O complexity",
                                    "4 algorithms run in lower Big O complexity",
                                    "5 algorithms run in lower Big O complexity"]))
        
        notes.append(Note(title: "Before the Interview",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm"]))
        
        topic = StudyTopic(name: "Technical Knowledge", imageName: "TK", notes: notes)
        allStudyTopics.append(topic)
    }
}

/*
 
 
 var topic = StudyTopic(name: "Intro", imageName: "Intro.png", subjects: ["The Interview Process",
 "Behind The Scenes",
 "Before The Interview",
 "Behavior Questions"],
 notes)
 allStudyTopics.append(topic)
 
 topic = StudyTopic(name: "Technical Knowledge", imageName: "TK", subjects: ["Big O",
 "Arrays and Strings",
 "Before The Interview",
 "Behavior Questions"])
 allStudyTopics.append(topic)

 
 */
