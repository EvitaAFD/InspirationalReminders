//
//  NotificationViewController.swift
//  notificationExtension
//
//  Created by David Porter on 5/21/18.
//  Copyright © 2018 Eve Denison. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Lottie


class NotificationViewController: UIViewController, UNNotificationContentExtension {

    var animationView: LOTAnimationView?
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func didReceive(_ notification: UNNotification) {

        self.label?.text = notification.request.content.body
        if let animationName = notification.request.content.userInfo["animationName"] as? String {
            self.addAnimation(animationName: animationName)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let xOffest = self.view.bounds.size.width / 2 - 130
        let yOffset = self.view.bounds.size.height / 2 - 60
        
        self.animationView?.frame = CGRect(x: xOffest, y: yOffset, width: 260, height: 260)
        
    }
    
    func addAnimation(animationName: String) {
        let animationView = LOTAnimationView(name: animationName)
        
        animationView.contentMode = .scaleAspectFill
        self.view.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
        self.animationView = animationView
        self.view.setNeedsLayout()
    }
}

