//
//  ParentHomeViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/28/20.
//

import UIKit
import Firebase
import UserNotifications
class ParentHomeViewController: UIViewController {
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(finalCode)
        print("heyy")
        ref = Database.database().reference()
        ref.child("codes").child(finalCode).child("messages").observe(.childAdded, with: {(snapshot) in
            print("COUNT ACTIVATED!!!")
            let data = snapshot.value as! String
            let content = UNMutableNotificationContent()
            content.title = "Drive Session Ended"
            content.body = data
            content.subtitle = "From Your Teen Driver"
            
            content.badge = 1
            content.sound = UNNotificationSound.default
            
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
            
            let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (nil) in
                
            }
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            
            }
        // Do any additional setup after loading the view.
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
