//
//  StudyViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/20/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class StudyViewController: UITableViewController {
    var studyStore: StudyStore!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyStore.allStudyTopics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        let topic = studyStore.allStudyTopics[indexPath.row]
        
        let image = UIImage(named: topic.imageName)
        
        cell.titleLabel.text = topic.name
        cell.imageView?.image = image
        
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNotes"{
            if let row = tableView.indexPathForSelectedRow?.row{
                
                let topic = studyStore.allStudyTopics[row]
                
                let subjectViewController = segue.destination as! NotesViewController
                subjectViewController.notes = topic.notes
                subjectViewController.name = topic.name
            }
        }
    }
}
