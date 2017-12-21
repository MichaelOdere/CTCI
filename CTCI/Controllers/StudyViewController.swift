import UIKit

class StudyViewController:UIViewController{
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var notes:[Note]!

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
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

        if indexPath.row % 2 == 0{
            cell.backgroundColor = CTCIPalette.primaryLightBlueBackgroundColor
        }else{
            cell.backgroundColor = CTCIPalette.secondaryLightBlueBackgroundColor
        }
        return cell
    }
}

extension StudyViewController:ZoomViewController{
    func zoomingView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return visibleView
    }
}

