import UIKit

class StudyViewController:UIViewController{
    @IBOutlet weak var visibleView: UIView!
    
}

extension StudyViewController:ZoomViewController{
    func zoomingCollectionViewCell(for transition: ZoomTransitioningDelegate) -> UIView? {
        return visibleView
    }
}
