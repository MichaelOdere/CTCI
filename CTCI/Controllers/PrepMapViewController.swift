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

        if isAnArrow(index: indexPath.item){
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArrowCell", for: indexPath) as! HorizontalArrowCell
            cell.arrowImage.image = getImage(index: indexPath.item)
            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! PrepMapContentCell

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
    
       
    }
    
    // C = Content
    // A = Arrow
    // [C, A, C, A, C, A, A, C, A, C, A, C, A, A]
    
    // This function returns the (A)rrow index's
    func isAnArrow(index: Int)->Bool{
        if (index % 7) % 2 == 1 || index % 7 == 6{
            return true
        }
        
        return false
    }
    
    // There are 3 Image directions (Right, Left, Down) and one nil case to decipher
    // nil is used for no image
    // [C, right, C, right, C, Down, nil, C, Left, C, Left, C, nil, Down]
    // Returns the correct IMage
    func getImage(index: Int)->UIImage?{
        let mod_7 = index % 7
        let mod_14 = index % 14
        let isLeft = mod_14 > 7
        
        // Right Case
        var img = UIImage(named: "arrow")

        // Down or Nil Case
        if mod_7 >= 5{
            // If it is the 5th spot AND the direction is right OR if it is the 6th spot AND the direction is left
            if mod_7 == 5 && !isLeft ||  mod_7 == 6 && isLeft{
                img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .right)
            }
            // Opposite of the cases above
            else{
                img = nil
            }
        }
            
        // Left Case
        else if isLeft{
            img = UIImage(cgImage: (img?.cgImage)!, scale: 1, orientation: .down)
        }
        
        return img
    }
}
