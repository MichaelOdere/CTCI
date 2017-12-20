import UIKit

class StudyViewController:UIViewController{
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var notes:[Note]!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension StudyViewController:UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        cell.title.text = notes[indexPath.row].title
        cell.bullets.text = notes[indexPath.row].getBullets()

        return cell
    }
}

extension StudyViewController:ZoomViewController{
    func zoomingCollectionViewCell(for transition: ZoomTransitioningDelegate) -> UIView? {
        return visibleView
    }
}

