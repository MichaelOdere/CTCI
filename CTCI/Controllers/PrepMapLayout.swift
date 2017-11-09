
import UIKit

class PrepMapLayout: UICollectionViewLayout {
    //1. Pinterest Layout Delegate
//    weak var delegate: PrepMapLayoutDelegate!
    
    //2. Configurable properties
    fileprivate var numberOfColumns = 5
    fileprivate var numberOfElementsInColumn = 7
    fileprivate var cellPadding: CGFloat = 6
    
    //3. Array to keep a cache of attributes.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //4. Content height and size
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        // Only calculate once
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        // Cell sizing parameters
        let ratio:CGFloat = 0.75
        let arrowSize:CGFloat = (contentWidth * (1-ratio)) / 2
        let mainWidth:CGFloat = (contentWidth * ratio) / 3
        let mainHeight:CGFloat = 125.0
        
        // Cell sizing arrays
        let height:[CGFloat] = [mainHeight, arrowSize, mainHeight, arrowSize,  mainHeight, arrowSize, arrowSize]
        let width:[CGFloat] = [mainWidth, arrowSize, mainWidth, arrowSize,  mainWidth, arrowSize , arrowSize]
        
        // Offset parameters
        var xOffset = [CGFloat]()
        var currentOffset:CGFloat = 0
        for column in 0 ..< numberOfElementsInColumn {
            if column < 5{
                xOffset.append(currentOffset)
                currentOffset += width[column]
            }else{
                let xOff = column == 5 ? xOffset[4]  + arrowSize / 2 : xOffset[0] + arrowSize / 2

                xOffset.append(xOff)
            }

        }
        var yOffset = [0, (mainHeight / 2 - arrowSize / 2), 0, (mainHeight / 2 - arrowSize / 2), 0, mainHeight, mainHeight]

        // Used to keep trach of which column we are on
        var column = 0

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let element = item % numberOfElementsInColumn
            let indexPath = IndexPath(item: item, section: 0)
            let isGoingLeft = item % 14 >= 7
            let h = height[item % numberOfElementsInColumn]
            let w = width[item % numberOfElementsInColumn]
            
            var xOffIndex = column
            
            if isGoingLeft{
                if item % 7 < 5{
                    xOffIndex = 4-column
                }
            }
            
            let frame = CGRect(x: xOffset[xOffIndex], y: yOffset[column], width: w, height: h)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            
            // When the content is an arrow the offset is the height of the main cell - the height of the arrow
            var yPos = element == 1 || element == 3 ? yOffset[column] + mainHeight : yOffset[column] + arrowSize
            
            if element >= 5{
                yPos = yOffset[column] + mainHeight
            }
            // Update the yoffset
            yOffset[column] = yPos + h + cellPadding
            
            // Determine the current column
            column = column < (numberOfElementsInColumn - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

