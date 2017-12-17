import UIKit

class LevelCell: UICollectionViewCell{

    private struct InternalConstants {
        static let alphaSmallestValue: CGFloat = 0.85
        static let scaleDivisor: CGFloat = 10.0
    }
    
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!

    @IBOutlet weak var lessonNumberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 20

    }
    open func scale(withCarouselInset carouselInset: CGFloat,
                    scaleMinimum: CGFloat = 0.9) {
        
        // Ensure we have a superView, and mainView
        guard let superview = superview else { return }
        
        // Get our absolute origin value
        let originX = superview.convert(frame, to: superview.superview).origin.x
        
        // Calculate our actual origin.x value using our inset
        let originXActual = originX - carouselInset
        
        let width = frame.size.width
        
        // Calculate our scale values
        let scaleCalculator = fabs(width - fabs(originXActual))
        let percentageScale = (scaleCalculator/width)
        
        let scaleValue = scaleMinimum
            + (percentageScale/InternalConstants.scaleDivisor)
        
        let alphaValue = InternalConstants.alphaSmallestValue
            + (percentageScale/InternalConstants.scaleDivisor)
        
        let affineIdentity = CGAffineTransform.identity
        
        // Scale our mainView and set it's alpha value
        self.transform = affineIdentity.scaledBy(x: scaleValue, y: scaleValue)
//        self.alpha = alphaValue
        
        // ..also..round the corners
        self.layer.cornerRadius = 20
    }
}
