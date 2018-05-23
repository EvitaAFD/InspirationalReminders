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
        self.animationView.contentMode = .scaleAspectFill
        self.view.addSubview(animationView)
        
       
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.animationView.play()
        self.label?.text = notification.request.content.body
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

