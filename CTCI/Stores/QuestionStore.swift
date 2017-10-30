//
//  QuestionStore.swift
//  CTCI
//
//  Created by Michael Odere on 10/22/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import Foundation

class QuestionStore{
    var allQuestionTopics = [QuestionTopic]()

    init(){
        var topic: QuestionTopic!
        var questions: [Question] = []
        var question: Question!
        
        question = Question(question: "How do you reverse this string?",
                            answer: "Iterate through the  array and place the character at the begnning",
                            codeImageName: "array.png",
                            hint: "This can be done in 0(N) time.",
                            complexity: "O(N)")
        questions.append(question)
        
        question = Question(question: "How do you reverse this string?",
                            answer: "Iterate through the  array and place the character at the begnning",
                            codeImageName: "array.png",
                            hint: "This can be done in 0(N) time.",
                            complexity: "O(N)")
        questions.append(question)
        
        topic = QuestionTopic(name: "Array", imageName: "array.png", questions: questions) //name: "Array", imageName: "array.png",
        allQuestionTopics.append(topic)
        
        questions.removeAll()
        
        
    }
    
}


