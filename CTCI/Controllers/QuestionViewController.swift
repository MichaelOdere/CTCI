import UIKit

class QuestionViewController:UIViewController{
    @IBOutlet weak var visibleView: UIView!
    
}

extension QuestionViewController:ZoomViewController{
    func zoomingCollectionViewCell(for transition: ZoomTransitioningDelegate) -> UIView? {
        return visibleView
    }
}

