import UIKit

class TopicCell: UICollectionViewCell{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSelf()
    }
    
    func initializeSelf(){
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        //UIColor(red: 160/255, green: 155/255, blue: 157/255, alpha: 1).cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
