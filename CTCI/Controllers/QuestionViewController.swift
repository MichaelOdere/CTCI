import UIKit

class QuestionViewController:UIViewController{
    @IBOutlet weak var visibleView: UIView!
    
}

extension QuestionViewController:ZoomViewController{
    func zoomingView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return visibleView
    }
}

