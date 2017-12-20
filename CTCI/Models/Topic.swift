import Foundation
import SwiftyJSON

class Topic {
    var title:String
    var currentLesson:Int
    var totalLessons:Int
    var lessons:[Lesson]
    
    init(title:String, currentLesson:Int, lessons:[Lesson]){
        self.title = title
        self.currentLesson = currentLesson
        self.totalLessons = lessons.count
        self.lessons = lessons
    }
    
    func currentLessonText()->String{
        
        return "\(currentLesson) of \(totalLessons) Completed"
    }
}
extension Topic {
    convenience init?(json: JSON, currentLesson:Int) {
        
        guard let title = json["title"].string else {
            print("Error parsing user object for key: title")
            return nil
        }

        guard let jsonLessons = json["lessons"].array else {
            print("Error parsing user object for key: lessons")
            return nil
        }
        
        var parsedLessons: [Lesson] = []
        for data in jsonLessons{
            if let lesson = Lesson(json: data){
                parsedLessons.append(lesson)
            }
        }

        self.init(title: title, currentLesson: currentLesson, lessons: parsedLessons)

    }
    
}

