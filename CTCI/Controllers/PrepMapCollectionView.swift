//
//  PrepMapCollectionViewController.swift
//  CTCI
//
//  Created by Michael Odere on 10/30/17.
//  Copyright © 2017 Michael Odere. All rights reserved.
//

import UIKit

class PrepMapCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let test = [1,2,3,4,5,6,7,8,9]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PrepMapContentCell
        
        cell.title.text = String(test[indexPath.row])
        let num = 100
        if num > 1{
            cell.duration.text = " \(num) days"
        }else{
            cell.duration.text = " \(num) day"
        }
        
        cell.descriptionText.text = "this is intentionally supposed to be a long amount of text in order to determine how much space I have! Feel free to continue as I will"
        return cell
    }
    
}

