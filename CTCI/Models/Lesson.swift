import Foundation

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
