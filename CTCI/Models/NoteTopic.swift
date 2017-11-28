class NoteTopic: Topic {
    
    var notes : [Note]
    
    init(name: String, imageName: String, notes:[Note]) {
        self.notes = notes
        super.init(name: name, imageName: imageName)
    }
}
