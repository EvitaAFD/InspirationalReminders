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
    var inspirationalQuotes = ["\"No one saves us but ourselves. No one can and no one may. We ourselves must walk the path.\" - Buddha", "\"Give, even if you only have a little.\" - Buddah", "\"Even as a solid rock is unshaken by the wind, so are the wise unshaken by praise or blame.\" - Buddah", "\"Nothing can harm you as much as your own thoughts unguarded.\" - Buddah"]
    
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
      
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        print("Cell selected at \(indexPath.item)")
    }

}

