//
//  ViewController.swift
//  MyNewNotifications
//
//  Created by Jason Crawford on 2/12/17.
//  Copyright © 2017 Jason Crawford. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                self.loadNotification()
            } else {
                print(error?.localizedDescription ?? "??")
            }
        })
    }

    @IBAction func notifyButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error in notification")
            }
        })
    }
    
    func loadNotification() {
        
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        // add attachment
        let myImage = "rick_grimes"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        // Create our notification content
        let notif = UNMutableNotificationContent()
        
        // only for extension 
        notif.categoryIdentifier =  "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error ?? "??")
                completion(false)
            } else {
                completion(true)
            }
            
        })
    }

}

