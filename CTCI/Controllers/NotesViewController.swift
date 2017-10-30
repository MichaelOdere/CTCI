//
//  NotesViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/22/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class NotesViewController : UITableViewController{
    var name: String!
    var notes: [Note]!
    
    var hasColor = false
    var color = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    @IBOutlet var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        navBar.title = name
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell",
                                                 for: indexPath) as! NoteCell
        
        let note = notes[indexPath.row]
        cell.title.text = note.title
        cell.bullets.text = note.getBullets()
        print(note.getBullets())
        
        if hasColor{
            cell.backgroundColor = color
            hasColor = false
        }else{
            hasColor = true
        }
        
        return cell
    }
}
