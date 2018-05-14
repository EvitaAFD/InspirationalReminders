//
//  ViewController.swift
//  InspirationalReminders
//
//  Created by Eve Denison on 5/13/18.
//  Copyright © 2018 Eve Denison. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Create reuse identifier for cell
    let cell = "cell"
    let inspirationalQuotes = ["\"No one saves us but ourselves. No one can and no one may. We ourselves must walk the path.\" - Buddha",
        "\"Give, even if you only have a little.\" - Buddah",
        "\"Even as a solid rock is unshaken by the wind, so are the wise unshaken by praise or blame.\" - Buddah",
        "\"Nothing can harm you as much as your own thoughts unguarded.\" - Buddah"]
    
    //Define number of cells in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return quotes in cell
        return self.inspirationalQuotes.count
    
    }
    
    //Create interactive movement of item at selected index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCellIdentifier", for: indexPath) as? QuoteCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        
        cell.cellLabel.text = self.inspirationalQuotes[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedQuote = self.inspirationalQuotes[indexPath.item]
        
        //Set up alert to confirm or cancel selection of quote user wants to be reminded of
        let alertController = UIAlertController(title: "Great Selection!", message:
            "Would you like to be reminded of this fab quote: \(selectedQuote)?", preferredStyle: UIAlertControllerStyle.alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (action) in
            
        }
        
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (action) in
            
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(dismissAction)
        
      /* When confirm is pressed define content using UNMutableNotificationContent() to contain selected quote, likely using seleced indexPath, next set time for local notification to occur using DateComponents() to set one minute from selection, third, create and register request with the notification system, lastly be sure to cancel the request */
        
        self.present(alertController, animated: true, completion: nil)
        print("Cell selected at \(indexPath.item)")
    }
    
    func scheduleNotification (withQuote quote: String) {
        
        
        
    }
}

