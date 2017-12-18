import UIKit

class StudyViewController:UIViewController{
    
}

extension StudyViewController:ZoomViewController{
    func zoomingCollectionViewCell(for transition: ZoomTransitioningDelegate) -> UIView? {
        return self.view
    }
}
