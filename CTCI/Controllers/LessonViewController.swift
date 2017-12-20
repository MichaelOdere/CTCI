import UIKit

class LessonViewController:UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    let cellScaling: CGFloat = 0.6
    @IBInspectable public var inset: CGFloat = 0
    var selectedIndexPath:IndexPath!
    var topic:Topic!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView?.contentInset = getInsets()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = CTCIPalette.primaryLightBlueBackgroundColor
        self.view.backgroundColor = collectionView.backgroundColor
        
    }
    
    func getInsets()->UIEdgeInsets{
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY:CGFloat = 0.0
        inset = insetX
       
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        return UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }

}

extension LessonViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topic.lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonCell", for: indexPath) as! LessonCell
        let lesson = topic.lessons[indexPath.row]
        cell.lessonNumberLabel.text = String(lesson.number)
        cell.descriptionLabel.text = lesson.descriptionText
        
        cell.studyButton.addTarget(self, action: #selector(loadView(_:)), for: .touchUpInside)
        cell.studyButton.tag = 0
        cell.quizButton.addTarget(self, action: #selector(loadView(_:)), for: .touchUpInside)
        cell.quizButton.tag = 1
        
        cell.indexPath = indexPath
        cell.scale(withCarouselInset: inset)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    @objc func loadView(_ sender:LessonButton){
        
        let sb = UIStoryboard(name: "Main", bundle: nil)

        selectedIndexPath = sender.indexPath
        
        if sender.tag == 0{
            let vc = sb.instantiateViewController(withIdentifier: "StudyViewController") as! StudyViewController
            vc.notes = topic.lessons[selectedIndexPath.row].notes
            self.navigationController?.pushViewController(vc, animated: true)
        
        }else if sender.tag == 1{
            let vc = sb.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension LessonViewController : UIScrollViewDelegate, UICollectionViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        for cell in collectionView.visibleCells{
            if let lessonCell = cell as? LessonCell {
                lessonCell.scale(withCarouselInset: inset)
            }

        }
    }
}

extension LessonViewController:ZoomViewController{
    func zoomingCollectionViewCell(for transition: ZoomTransitioningDelegate) -> UIView? {
        if let indexPath = selectedIndexPath{
            let cell = collectionView?.cellForItem(at: indexPath) as! LessonCell
            let frame = collectionView.convert(cell.frame, to: self.view)
            let v = UIView(frame: frame)
            v.backgroundColor = cell.backgroundColor

            return v
        }
        return nil
    }
}

