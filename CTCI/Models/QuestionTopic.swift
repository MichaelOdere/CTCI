import Foundation

class QuestionTopic: Topic{
    
    var questions: [Question]
    
    init(name: String, imageName: String, questions: [Question]) {
        self.questions = questions
       
        super.init(name: name, imageName: imageName)

    }
    
}
