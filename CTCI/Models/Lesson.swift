import Foundation
import SwiftyJSON

class Lesson {
    var title: String
    var descriptionText: String
    var number: Int
    var notes:[Note]
    var questions:[Question]
    
    init(title:String, descriptionText:String, number:Int, notes:[Note], questions:[Question]){
        self.title = title
        self.descriptionText = descriptionText
        self.number = number
        self.notes = notes
        self.questions = questions
    }
    
}

extension Lesson {
    convenience init?(json: JSON) {
        
        guard let title = json["title"].string else {
            print("Error parsing user object for key: title")
            return nil
        }
        
        guard let descriptionText = json["descriptionText"].string else {
            print("Error parsing user object for key: descriptionText")
            return nil
        }
        
        guard let number = json["number"].int else {
            print("Error parsing user object for key: number")
            return nil
        }
        
        guard let jsonNotes = json["notes"].array else {
            print("Error parsing user object for key: notes")
            return nil
        }
        
        guard let jsonQuestions = json["questions"].array else {
            print("Error parsing user object for key: questions")
            return nil
        }
        
        var parsedNotes: [Note] = []
        for data in jsonNotes{
            if let note = Note(json: data){
                parsedNotes.append(note)
            }
        }
        
        var parsedQuestions: [Question] = []
        for data in jsonQuestions{
            if let question = Question(json: data){
                parsedQuestions.append(question)
            }
        }
        
        self.init(title: title, descriptionText: descriptionText, number: number, notes: parsedNotes, questions: parsedQuestions)
    }
}
