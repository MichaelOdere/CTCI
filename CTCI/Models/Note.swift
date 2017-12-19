import Foundation
import SwiftyJSON

class Note {
    var title:String
    var descriptionText:String
    
    init(title:String, descriptionText:String) {
        self.title = title
        self.descriptionText = descriptionText
    }
    
}

extension Note {
    convenience init?(json: JSON) {

        guard let title = json["title"].string else {
            print("Error parsing user object for key: title")
            return nil
        }
        
        guard let descriptionText = json["descriptionText"].string else {
            print("Error parsing user object for key: descriptionText")
            return nil
        }
        
        self.init(title: title, descriptionText: descriptionText)
    }
}
