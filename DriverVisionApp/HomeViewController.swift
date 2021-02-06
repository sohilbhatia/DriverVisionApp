//
//  HomeViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/27/20.
//

import UIKit
import UserNotifications
import Firebase
var speedlim = 0
var speedTest = 0.0
var numberOfAlerts = [] as [String]
class HomeViewController: UIViewController {
    var ref: DatabaseReference!
    
   
    @IBOutlet var welcome: UILabel!
    
   
    @IBAction func onShift(_ sender: Any) {
        let map_vc = self.storyboard?.instantiateViewController(identifier: "map_vc") as! MapViewController
        self.view.window?.rootViewController = map_vc
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func onClick(_ sender: Any) {
        ref = Database.database().reference()
        let content = UNMutableNotificationContent()
        content.title = "Click Notification"
        content.body = "Button Clicked!"
        content.subtitle = "subtitle"
        
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (nil) in
            
        }
        self.ref.child("codes").child(myCode).child("messages").setValue(["message":"button was clicked"])
        
        

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [self] (didAllow, error) in
            if let label = welcome {
                label.textColor = .black
            }
            
            
        // Do any additional setup after loading the view.
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
}
