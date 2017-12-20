import UIKit

class TopicsViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var topicStore:TopicStore!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
       animateCollectionView()
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
        return cell
    }
    
    
}
