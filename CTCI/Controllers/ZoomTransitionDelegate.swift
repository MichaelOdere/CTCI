import UIKit

@objc protocol ZoomViewController {
    func zoomingView(for transition: ZoomTransitioningDelegate) -> UIView?
}

@objc protocol ZoomPieViewController {
    func zoomingPieView(for transition: ZoomTransitioningDelegate) -> MyPieChartView?
}

enum TransitionState{
    case initial
    case final
}

enum TransitionType{
    case pieView
    case lessonView
}

class ZoomTransitioningDelegate:NSObject{
    var transitionDuration = 0.5
    var operation: UINavigationControllerOperation = .none
    var transitionType: TransitionType!
    
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (uiView: UIView, uiView:UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, foregroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews){
        
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            
            foregroundViewController.view.transform =  CGAffineTransform(translationX: 0, y: foregroundViewController.view.frame.height)
            
            snapshotViews.uiView.frame = containerView.convert(viewsInBackground.uiView.frame, from: viewsInBackground.uiView.superview)
            snapshotViews.uiView.layer.cornerRadius = 20
       
        case .final:
            
            foregroundViewController.view.transform =  CGAffineTransform.identity
            
            snapshotViews.uiView.frame = containerView.convert(viewsInForeground.uiView.frame, from: viewsInForeground.uiView.superview)
            snapshotViews.uiView.layer.cornerRadius = 0
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func getVC(vc:UIViewController)->UIView?{
        switch transitionType {
        case .pieView:
            return (vc as? ZoomPieViewController)?.zoomingPieView(for: self)
        case .lessonView:
            return (vc as? ZoomViewController)?.zoomingView(for: self)
        default:
            return nil
        }
    }
    
    func getViewSnapShot(foregroundView:UIView)->UIView?{
        switch transitionType {
        case .pieView:
            let pieView = MyPieChartView(frame: foregroundView.frame)
            pieView.data = (foregroundView as? MyPieChartView)?.data
            return pieView
        case .lessonView:
           return UIView(frame: foregroundView.frame)
        default:
            return nil
        }
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView

        var backgroundVC = fromVC
        var foregroundVC = toVC

        if operation == .pop{
            backgroundVC = toVC
            foregroundVC = fromVC
        }

        let maybeBackgroundView = getVC(vc: backgroundVC)
        let maybeForegroundView = getVC(vc: foregroundVC)

        assert(maybeBackgroundView != nil, "Cannot find view in background")
        assert(maybeForegroundView != nil, "Cannot find view in foreground")

        let backgroundView = maybeBackgroundView!
        let foregroundView = maybeForegroundView!
        
        let maybeViewSnapshot = getViewSnapShot(foregroundView: foregroundView)
        assert(maybeViewSnapshot != nil, "Cannot find view in viewSnapShot")

        let viewSnapshot = maybeViewSnapshot!

        viewSnapshot.backgroundColor = backgroundView.backgroundColor
        viewSnapshot.layer.masksToBounds = true
        
        backgroundView.isHidden = true
        foregroundView.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundVC.view.backgroundColor
        foregroundVC.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundVC.view)
        containerView.addSubview(foregroundVC.view)
        containerView.addSubview(viewSnapshot)
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop{
            preTransitionState = .final
            postTransitionState = .initial
            
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundVC, foregroundViewController: foregroundVC, viewsInBackground: (backgroundView, backgroundView), viewsInForeground: (foregroundView,foregroundView), snapshotViews: (viewSnapshot, viewSnapshot))
        
        foregroundVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundVC, foregroundViewController: foregroundVC, viewsInBackground: (backgroundView, backgroundView), viewsInForeground: (foregroundView,foregroundView), snapshotViews: (viewSnapshot, viewSnapshot))
            
        }) { (finished) in
            backgroundVC.view.transform = CGAffineTransform.identity
            
            viewSnapshot.removeFromSuperview()
            backgroundView.isHidden = false
            foregroundView.isHidden = false
            
            foregroundVC.view.backgroundColor = foregroundViewBackgroundColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC is ZoomViewController && toVC is ZoomViewController{
            self.operation = operation
            self.transitionType = .lessonView
            return self
        }else if fromVC is ZoomPieViewController && toVC is ZoomPieViewController{
            self.operation = operation
            self.transitionType = .pieView
            return self
        }else{
            return nil
        }
    }
}

