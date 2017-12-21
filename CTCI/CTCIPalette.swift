import UIKit

public struct CTCIPalette {
    static public let backgroundColor = UIColor(r: 0, g: 0, b: 0)
    static public let primaryLightBlueBackgroundColor = UIColor(r: 162, g: 209, b: 220)
    static public let secondaryLightBlueBackgroundColor = UIColor(r: 194, g: 230, b: 240)
    static public let vanillaBackgroundColor = UIColor(r: 242, g: 242, b: 235)
    static public let completeColor = UIColor(r: 11, g: 170, b: 138)
    static public let incompleteColor = UIColor(r: 252, g: 66, b: 110)

    
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
