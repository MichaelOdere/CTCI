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
        
        if (test[indexPath.row] % 7) % 2 == 1 || test[indexPath.row] % 7 == 6{
            let otherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            
            var img = UIImage(named: "arrow")
            
            // DIrection of the arrow
            if test[indexPath.row] % 7 >= 5{
                if test[indexPath.row] % 7 == 5 && test[indexPath.row] % 14 < 7{
                    img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .right)
                }else if test[indexPath.row] % 7 == 6 && test[indexPath.row] % 14 > 7{
                    img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .right)
                }else{
                    img = nil
                }

            }
            else if indexPath.row % 14 > 7{
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
        
        cell.descriptionText.text = "this is ll"
        
        cell.sizeToFit()
        return cell
    }
    
    func getCellType(index: Int){
        
    }
}
