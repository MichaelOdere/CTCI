import Foundation
import SwiftyJSON

class Question {
    var question: String
    var answer: String
    
    init(question:String, answer:String) {
        self.question = question
        self.answer = answer
    }
    
}

extension Question {
    convenience init?(json: JSON) {
        
        guard let question = json["question"].string else {
            print("Error parsing user object for key: question")
            return nil
        }
        
        guard let answer = json["answer"].string else {
            print("Error parsing user object for key: answer")
            return nil
        }
        
        self.init(question: question, answer: answer)
    }
}
