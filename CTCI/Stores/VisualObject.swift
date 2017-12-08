import UIKit

class VisualObject:UILabel{
    
    struct SwapPositions {
        var above:CGPoint
        var aboveSlide:CGPoint
        var slide:CGPoint
        var origin:CGPoint
        var destination:CGPoint
    }
    
    var value:Int
    
    init(frame: CGRect, value:Int) {
        self.value = value
        
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIntoPlace(width: CGFloat, delay:CGFloat){
        
        self.transform = CGAffineTransform(translationX: -width, y: 0)
        
        UIView.animate(withDuration: 0.8, delay: TimeInterval(delay), options: .curveEaseInOut, animations: {
            self.transform = .identity
        })
    }
    
    func swapAnimation(destination: CGPoint){

        let positions = getSwapPositions(origin: self.frame.origin, destination: destination)
        let path = UIBezierPath()
        
        path.move(to: positions.origin)
        path.addLine(to: positions.above)
        path.addLine(to: positions.aboveSlide)
        path.addLine(to: positions.slide)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        anim.duration = 1.0
        self.layer.add(anim, forKey: "position")
        self.frame.origin = positions.destination

    }
    
    func getSwapPositions(origin:CGPoint, destination: CGPoint)->SwapPositions{
        let above = CGPoint(x: self.frame.origin.x + self.frame.width / 2, y: origin.y - self.frame.height)
        let aboveSlide = CGPoint(x: destination.x + self.frame.width / 2, y: origin.y - self.frame.height)
        let slide = CGPoint(x: destination.x + self.frame.width / 2, y: origin.y + self.frame.height / 2)
        let origin = CGPoint(x: above.x, y: slide.y)
        
        let positions = SwapPositions(above: above, aboveSlide: aboveSlide, slide: slide, origin: origin, destination: destination)
        return positions
    }
}

