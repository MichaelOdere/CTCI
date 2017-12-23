import UIKit

class TopicCell: UICollectionViewCell{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var myPieChartView: MyPieChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSelf()
    }
    
    func initializeSelf(){
        self.backgroundColor = UIColor.white
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
