import Foundation
import SwiftyJSON

class Note {
    var title: String
    var bullets: [String]
    
    init(title: String, bullets: [String]) {
        self.title = title
        self.bullets = bullets
        
    }
    
    func getBullets()-> String{
        
        var bulletsFormat = ""
        for b in bullets{
            bulletsFormat.append("\u{2022}  ")
            bulletsFormat.append(b)
            bulletsFormat.append("\n")
            
        }
        
        return bulletsFormat
    }
}

extension Note {
    convenience init?(json: JSON) {

        guard let title = json["title"].string else {
            print("Error parsing user object for key: title")
            return nil
        }
        
        guard let jsonBullets = json["bullets"].array else {
            print("Error parsing user object for key: bullets")
            return nil
        }
        
        var parsedBullets:[String] = []
        for data in jsonBullets{
            if let str = data["bullet"].string{
                parsedBullets.append(str)
            }
        }
        print("Bullets!!!!!!!!!!!!!!!!")
        print(parsedBullets)
        self.init(title: title, bullets: parsedBullets)
    }
}
