class StudyStore {
    
    var allNoteTopic = [NoteTopic]()
    
    init() {
        var notes: [Note] = []
        var topic: NoteTopic!
        
        notes.append(Note(title: "Definition",
                         bullets: ["Big O is used to describe computer complextiy of an algorithm",
                                   "Good algorithms run in lower Big O complexity"]))
        notes.append(Note(title: "Big O",
                          bullets: ["Big O is used to describe computer complextiy of an algorithm",
                                    "Good algorithms run in lower Big O complexity"]))
        topic = NoteTopic(name: "Big O", imageName: "Intro.png", notes: notes)
        allNoteTopic.append(topic)
        
        notes.removeAll()
        
        notes.append(Note(title: "Before the Interview",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm",
                                    "Good algorithms run in lower Big O complexity"]))
        notes.append(Note(title: "4 O",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm",
                                    "2 algorithms run in lower Big O complexity",
                                    "3 algorithms run in lower Big O complexity",
                                    "4 algorithms run in lower Big O complexity",
                                    "5 algorithms run in lower Big O complexity"]))
        
        notes.append(Note(title: "Before the Interview",
                          bullets: ["1 O is used to describe computer complextiy of an algorithm"]))
        
        topic = NoteTopic(name: "Technical Knowledge", imageName: "TK", notes: notes)
        allNoteTopic.append(topic)
    }
}

