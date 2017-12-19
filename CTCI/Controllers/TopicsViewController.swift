import UIKit

class TopicsViewController:UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var topicStore:TopicStore!
    
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension TopicsViewController:UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LessonViewController") as! LessonViewController
        vc.topic = topicStore.allTopics[indexPath.row]
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
