//
//  ViewController.swift
//  InspirationalReminders
//
//  Created by Eve Denison on 5/13/18.
//  Copyright © 2018 Eve Denison. All rights reserved.
//

import UIKit
import UserNotifications
import Lottie

enum GoalSteps: String, EnumCollection {
    
    case whoWillBeInCharge = "WHO WILL BE IN CHARGE"
    case whoWillWatchKids = "WHO WILL WATCH MY KIDS"
    case whoWillGetAssets = "WHO WILL GET MY ASSESTS"
    case whoWillGetThings = "WHO WILL GET MY THINGS"
    case whatHeirsWillGet = "WHAT HEIRS WILL GET"
    case whoCanAccess = "WHO CAN ACCESS WHAT"
    
    var animation: String {
        switch self {
        case .whoWillBeInCharge:
            return "Will"
        case .whoWillWatchKids:
            return "Family"
        case .whoWillGetAssets:
            return "Condo"
        case .whoWillGetThings:
            return "Vault"
        case .whatHeirsWillGet:
            return "Trust"
        case .whoCanAccess:
            return "Roles"
        }
    }
    
    var displayName: String {
        return self.rawValue
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    // Create an instance of the UNNotificationActionClass
    struct Notification {
        
        struct Category {
            
            static let goal = "goal"
        }
        
        struct Action {
            
            static let showGoal = "showGoal"
        }
    }
    
    let notificationCenter =  UNUserNotificationCenter.current()
    //Create reuse identifier for cell
    let cell = "cell"
    // TODO: can we access display name on allValues, if so how?
    let goalNames = [GoalSteps.whoWillBeInCharge.displayName, GoalSteps.whoWillWatchKids.displayName, GoalSteps.whoWillGetAssets.displayName, GoalSteps.whoWillGetThings.displayName, GoalSteps.whatHeirsWillGet.displayName, GoalSteps.whoCanAccess.displayName]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserNotificationCenter()
    }
    
    
    private func configureUserNotificationCenter() {
        
        // Configure user notification center and assign delegate to self.
        UNUserNotificationCenter.current().delegate = self
        
        // Define action
        let showGoalAction = UNNotificationAction(identifier: Notification.Action.showGoal, title: "Complete This Goal", options: [.foreground])
        
        // Define category for goals to handle actions on alert.
        let goalCategory = UNNotificationCategory(identifier: "goal", actions: [showGoalAction], intentIdentifiers: [], options: [])
        
        // Register category with notification center
        UNUserNotificationCenter.current().setNotificationCategories([goalCategory])
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
        
        // Return goals in cell
        return self.goalNames.count
    }
    
    //Create interactive movement of item at selected index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCellIdentifier", for: indexPath) as? QuoteCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.cellLabel.text = self.goalNames[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let goal = self.goalNames[indexPath.item]
        
        // Set up alert to confirm or cancel selection of goals user wants to be reminded of
        let alertController = UIAlertController(title: "Great Selection!", message:
            "Would you like to be reminded to complete my: \(goal.capitalized) goal?", preferredStyle: UIAlertControllerStyle.alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (action) in
            self.createNotification(withGoal: goal)
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (action) in
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createNotification (withGoal goal: String) {
        
        let content = UNMutableNotificationContent()
        content.title = "Goal Reminder"
        content.body = goal
        content.categoryIdentifier = "goal"
        
        if let goalStep = GoalSteps(rawValue: goal) {
            content.userInfo = ["animationName": goalStep.animation]
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: goal, content: content, trigger: trigger)
        
        self.notificationCenter.add(request, withCompletionHandler: nil)
    }
}

// MARK: UNUserNotificationDelegate
extension ViewController: UNUserNotificationCenterDelegate {
    
    // Allows more control over how local notifcations are handled and allows us to see notification even if app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
            
        case Notification.Action.showGoal:
            let selectedGoal = response.notification.request.identifier
            self.navigateToSelectedGoal(selectedGoal)
        default:
            print("Unidentified Action")
        }
        
        completionHandler()
    }
    
    func navigateToSelectedGoal(_ selectedGoal: String) {
        
        if let index = goalNames.index(of: selectedGoal) {
            
            self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionViewScrollPosition.centeredVertically, animated: true)
        }
    }
}

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}

