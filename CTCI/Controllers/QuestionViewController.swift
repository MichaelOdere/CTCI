//
//  QuestionViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/22/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class QuestionViewController: UITableViewController{
    var questionStore: QuestionStore!
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionStore.allQuestionTopics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        let questionTopic = questionStore.allQuestionTopics[indexPath.row]
        cell.titleLabel.text = questionTopic.name
        
        let image = UIImage(named: questionTopic.imageName)
        cell.imageView?.image = image
        return cell
    }
}
