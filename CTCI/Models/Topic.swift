import Foundation

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
    
    
}
