import UIKit

class LevelViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellScaling: CGFloat = 0.6

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
//        layout.itemSize.width = cellWidth
//        print("cell width \(cellWidth)")
//        print("cell height \(cellHeight)")
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)

        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {

        collectionView.frame.origin.y += self.view.frame.height
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView.frame.origin.y -= self.view.frame.height
        }, completion: nil)
    }
    

}

extension LevelViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCell", for: indexPath) as! LevelCell
        print("cell")
        cell.lessonNumberLabel.text = "1 or 4"
        cell.descriptionLabel.text = "Describe this!"
        return cell
    }
}

extension LevelViewController : UIScrollViewDelegate, UICollectionViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    
}
