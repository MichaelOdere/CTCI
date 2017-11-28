import UIKit

class PrepMapContentCell:UICollectionViewCell{
   
    @IBOutlet var view: PrepMapView!

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = false

    }
    
    func daysText(days:Int)->String{
        if days == 1{
            return "\(days) day"
        }else{
            return "\(days) days"
        }
    }
    
}


