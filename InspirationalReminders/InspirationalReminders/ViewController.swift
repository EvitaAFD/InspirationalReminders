//
//  ViewController.swift
//  InspirationalReminders
//
//  Created by Eve Denison on 5/13/18.
//  Copyright © 2018 Eve Denison. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Create reuse identifier for cell
    let cell = "cell"
    var inspirationalQuotes = ["1", "2", "3", "4"]
    
    //Define number of cells in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return quotes in cell
        return self.inspirationalQuotes.count
    
    }
    
    //Create interactive movement of item at selected index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuoteCollectionViewCell
        
        cell.cellLabel.text = self.inspirationalQuotes[indexPath.item]
        cell.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Great Selection!", message:
            "Would you like to be reminded of this fab quote?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        print("Cell selected at \(indexPath.item)")
    }

}

