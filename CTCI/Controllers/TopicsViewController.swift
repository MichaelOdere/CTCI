import UIKit
import Charts

class TopicsViewController:UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    var topicStore:TopicStore!
    var selectedIndexPath:IndexPath!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
//       animateCollectionView()
    }
    
    func animateCollectionView(){
        let originalCenter = collectionView.center
        collectionView.alpha = 0.0
        collectionView.center = CGPoint(x: self.view.frame.width , y: 0)
        collectionView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.25, delay: 0.1, options: [.curveEaseOut], animations: {
            self.collectionView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.collectionView.center = originalCenter
            self.collectionView.alpha = 1.0
        }, completion: nil)
    }
}


extension TopicsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LessonViewController") as! LessonViewController
        vc.topic = topicStore.allTopics[indexPath.row]
        vc.hidesBottomBarWhenPushed = true  
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicStore.allTopics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        let index = indexPath.row
        let topic = topicStore.allTopics[index]
        cell.titleLabel.text = topic.title
        cell.levelLabel.text = topic.currentLessonText()
        let unitsSold:[Double] = [Double(topic.currentLesson), Double(topic.totalLessons-topic.currentLesson)]
        let months = ["\(topic.currentLesson) Completed", "\(topic.totalLessons - topic.currentLesson ) To Learn"]
        cell.myPieChartView.setChart(dataPoints: months, values: unitsSold)
        cell.myPieChartView.isUserInteractionEnabled = false
        cell.myPieChartView.data?.setDrawValues(false)

        cell.myPieChartView.alpha = 0.5
        return cell
    }
}

extension TopicsViewController:ZoomPieViewController{
    func zoomingPieView(for transition: ZoomTransitioningDelegate) -> MyPieChartView? {
        if let indexPath = selectedIndexPath{
            let cell = collectionView?.cellForItem(at: indexPath) as! TopicCell
            return cell.myPieChartView
        }
        return nil
    }
}

