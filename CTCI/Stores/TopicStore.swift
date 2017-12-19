import SwiftyJSON

class TopicStore {
    
    var allTopics = [Topic]()
    
    init(){
        
        if let path = Bundle.main.path(forResource: "CTCI_Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)

                guard let jsonTopics = json["topics"].array else {
                    print("Error parsing user object for key: title")
                    return
                }
                
                for data in jsonTopics{
                    if let topic = Topic(json: data, currentLesson: 0){
                        allTopics.append(topic)
                    }
                    
                }
                
            } catch {
                print(error)
            }
        }
        
    }
    
}


