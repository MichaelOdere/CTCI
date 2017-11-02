//
//  MapViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/26/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    let test = Array(0...29)
    
    @IBOutlet var collectionView: UICollectionView!
    //    @IBOutlet var navBar: UINavigationItem!
    
    override func viewDidLoad() {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)

    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! PrepMapContentCell
        
        if test[indexPath.row] % 5 == 1 || test[indexPath.row] % 5 == 3{
            let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            
            var img = UIImage(named: "arrow")
            
            // DIrection of the arrow
            if indexPath.row % 10 > 5{
                img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .down)
            }
            
            otherCell.arrowImage.image = img

            return otherCell
        }
        cell.title.text = String(test[indexPath.row])
        let num = 100
        if num > 1{
            cell.duration.text = " \(num) days"
        }else{
            cell.duration.text = " \(num) day"
        }
        
        cell.descriptionText.text = "this is intentionally supposed to be a long amount of text in order to determine how much space I have! Feel free to continue as I will"
        
        cell.sizeToFit()
        return cell
    }
    
}
