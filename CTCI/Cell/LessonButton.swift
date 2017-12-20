import UIKit

class LessonButton:UIButton {
    
    var indexPath:IndexPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeButton()
    }
    
    func initializeButton(){
        self.layer.cornerRadius = 10
        self.backgroundColor = CTCIPalette.primaryLightBlueBackgroundColor
        self.setTitleColor(UIColor.black, for: .normal)
    }
}
