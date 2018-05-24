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

    let animationView = LOTAnimationView(name: "Kayak")
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(animationView)
        self.animationView.frame = CGRect(x: 0, y: 0, width: 260, height: 260)
        self.animationView.center = self.view.center
        self.animationView.contentMode = .scaleAspectFill
        self.animationView.loopAnimation = true
        self.animationView.play()
        
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

