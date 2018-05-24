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
        self.animationView.loopAnimation = true
        self.animationView.play()
    }
    
    func didReceive(_ notification: UNNotification) {
        
        self.label?.text = notification.request.content.body
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let xOffest = self.view.bounds.size.width / 2 - 130
        let yOffset = self.view.bounds.size.height / 2 - 60
        
        self.animationView.frame = CGRect(x: xOffest, y: yOffset, width: 260, height: 260)
        self.animationView.contentMode = .scaleAspectFill
    }
}

