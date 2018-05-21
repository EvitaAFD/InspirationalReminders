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
    
    // Create an instance of the UNNotificationActionClass
    struct Notification {
        
        struct Category {
            
            static let quote = "quote"
        }
        
        struct Action {
            
            static let showQuote = "showQuote"
            static let cancel = "cancel"
        }
        
    }
    
    let notificationCenter =  UNUserNotificationCenter.current()
    
    //Create reuse identifier for cell
    let cell = "cell"
    let inspirationalQuotes = [
        "\"No one saves us but ourselves. No one can and no one may. We ourselves must walk the path.\" - Buddha",
        "\"Give, even if you only have a little.\" - Buddah",
        "\"Even as a solid rock is unshaken by the wind, so are the wise unshaken by praise or blame.\" - Buddah",
        "\"Nothing can harm you as much as your own thoughts unguarded.\" - Buddah"]
    
    override func viewDidLoad() {
        
        configureUserNotificationCenter()
    }
       
    override func viewDidAppear(_ animated: Bool) {
        
        self.notificationCenter.getNotificationSettings { (settings) in
            
            if settings.authorizationStatus != .authorized {
                DispatchQueue.main.async {
                    
                    let options: UNAuthorizationOptions = [.alert]
                    
                    self.notificationCenter.requestAuthorization(options: options, completionHandler: { (granted, error) in
                        
                    })
                    
                }
            }
        }
    }
    
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
        
        let quote = self.inspirationalQuotes[indexPath.item]
        
        // Set up alert to confirm or cancel selection of quote user wants to be reminded of
        let alertController = UIAlertController(title: "Great Selection!", message:
            "Would you like to be reminded of this fab quote: \(quote)?", preferredStyle: UIAlertControllerStyle.alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (action) in
            self.createNotification(withQuote: quote)
            
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
        print("Cell selected at \(indexPath.item)")
    }
    
    func createNotification (withQuote quote: String) {
        let content = UNMutableNotificationContent()
        content.title = "Inspirational Reminder"
        content.body = quote
        
        self.scheduleNotification(withContent: content)
        
    }
    
    func scheduleNotification(withContent content: UNMutableNotificationContent) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let request = UNNotificationRequest(identifier: "InspirationalQuote", content: content, trigger: trigger)
        
        // Set Category Identifier
        content.categoryIdentifier = Notification.Category.quote
        
        self.notificationCenter.add(request, withCompletionHandler: nil)
        
    }
    
    private func configureUserNotificationCenter() {
        
        // Configure user notification cetner and assign delegate to self.
        UNUserNotificationCenter.current().delegate = self
        
        // Define action
        let showQuoteAction = UNNotificationAction(identifier: Notification.Action.showQuote, title: "View Sweet Quote", options: [.foreground])
        let cancelQuoteDisplayAction = UNNotificationAction(identifier: Notification.Action.cancel, title: "Cancel", options: [.destructive])
        
        // Define category for quotes to handle actions on alert, can add an unsubscribe action as well
        let quoteCategory = UNNotificationCategory(identifier: Notification.Category.quote, actions: [showQuoteAction, cancelQuoteDisplayAction], intentIdentifiers: [], options: [])
        
        // Register category with notification center
        UNUserNotificationCenter.current().setNotificationCategories([quoteCategory])
    }
}

// MARK: UNUserNotificationDelegate
extension ViewController: UNUserNotificationCenterDelegate {
    
    // Allows more control over how local notifcations are handled and allows us to see notification even if app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.showQuote:
            print("User taped to show quote")
        case Notification.Action.cancel:
            print("User canceled display")
        default:
            print("Unidentified Action")
        }
        completionHandler()
    }
}


