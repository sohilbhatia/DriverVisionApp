//
//  PreViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/2/21.
//

import UIKit
import Lottie
import CoreLocation
import UserNotifications
import Firebase
import MapKit

class PreViewController: UIViewController {

   
    @IBOutlet var aniView: UIView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var dateTxt: UILabel!
    struct Course {
        let first: Array<Any>
        let second: Dictionary<String, Any>
        let third: Array<Any>
        let fourth: Dictionary<String, Any>
        let fifth: Array<Any>
        let sixth: Dictionary<String, Any>
        let SPEEDLIMIT: Int
        init(json: [String: Any]) {
            first = json["resourceSets"] as! Array<Any>
            second = first[0] as! Dictionary<String, Any>
            third = second["resources"] as! Array<Any>
            fourth = third[0] as! Dictionary<String, Any>
            fifth = fourth["snappedPoints"] as! Array<Any>
            sixth = fifth[0] as! Dictionary<String, Any>
            SPEEDLIMIT = sixth["speedLimit"] as? Int ?? 0
            
        }
    }
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        var aniv =  AnimationView(name: "car")
        super.viewDidLoad()
        //mainTitle.text = "Hello " + name + "!"
        let date = Date()
        mainTitle.font = UIFont(name: "Avenir", size: 40)
        dateTxt.font = UIFont(name: "Avenir", size: 18)
        // MARK: Way 1
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: date)
        
        dateTxt.text = dateString
        
        
        aniv = AnimationView(name: "mycar")
        aniv.contentMode = .scaleAspectFit
        self.aniView.addSubview(aniv)
        aniView.frame = self.aniView.bounds
        aniv.play(fromProgress: 0,
                               toProgress: 1,
                               loopMode: LottieLoopMode.loop,
                               completion: { (finished) in
                                if finished {
                                  print("Animation Complete, Start second one")
                                } else {
                                  print("Animation cancelled")
                                }
            })
        
        
        // Do any additional setup after loading the view.
    }
    
    class MapViewController: UIViewController, CLLocationManagerDelegate {
        var ref: DatabaseReference!
      
        var SPDlim = Int()
        let manager = CLLocationManager()
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[0]
            
            guard let mostRecentLocation = locations.last else {
                return
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = mostRecentLocation.coordinate
            
            
            
            
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region = MKCoordinateRegion(center: myLocation, span: span)
            
            //map.setRegion(region, animated: true)
            ///self.map.showsUserLocation = true
            var finalSpeed = location.speed
            if (finalSpeed < 0) {
                finalSpeed = 0
            }
            //speed.text = "Current Speed: " + String(round((speedTest * 2.24)*10) / 10) + " MPH"
            
            let jsonUrlString = "https://dev.virtualearth.net/REST/v1/Routes/SnapToRoad?points=\(location.coordinate.latitude),\(location.coordinate.longitude)&includeTruckSpeedLimit=true&IncludeSpeedLimit=true&speedUnit=MPH&travelMode=driving&key=AgqimMOPfDALglebExqcY5DFuVFrl1TE75EPl6jpYZvKlHR3oMQCDjGxgok-3Dwb"
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                //perhaps check err
                //also perhaps check response status 200 OK
                
                guard let data = data else { return }
                
                //let dataAsString = String(data: data, encoding: .utf8)
                //print(dataAsString)
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                    
                    let roadInfo = Course(json: json)
                    DispatchQueue.main.async {
                        speedlim = roadInfo.SPEEDLIMIT
                        
                        speedTest = location.speed

                    }
                    

                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                
                
                
            }.resume()
            //speedlimit.text = "Speed Limit: " + String(speedlim) + " MPH"
            
            if(((Int(speedlim) / 2) - Int(speedTest)) < 0) {
                //print("Status: Alert")
                
                //numberOfAlerts.remove(at: 1)
                
                numberOfAlerts.append("1")
            }
            else if(speedTest == 0.0) {
                numberOfAlerts.append("STILL")
            }
            else {
                //print("Status: OK")
                //numberOfAlerts.remove(at: 0)
                //numberOfAlerts.remove(at: 1)
                numberOfAlerts.append("0")
            }
            
            var countAlert = 0
            var countOK = 0
            var countStill = 0
            var countDistracted = 0
            for i in numberOfAlerts {
                if(i == "1") {
                    countAlert += 1
                    overSpeedPercentage = Double(countAlert) / Double(numberOfAlerts.count) * 100
                    countStill = 0
                }
                else if(i == "0") {
                    countOK += 1
                    countStill = 0
                }
                else if(i == "STILL") {
                    countStill += 1
                    if(countStill >= 10) {
                        print("COUNT AT 10 ")
                        let content = UNMutableNotificationContent()
                        content.title = "Drive Session Ended"
                        content.body = "You went over the speedlimit " + String(Int(overSpeedPercentage)) + "% of the time."
                        
                        content.sound = UNNotificationSound.default
                        
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                        
                        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        countStill = 0
                        self.ref.child("codes").child(myCode).child("messages").setValue(["message": "Your teenager went over the speedlimit " + String(Int(overSpeedPercentage)) + "% of the time."])
                        //numberOfAlerts.removeAll()
                    }
                }
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
}
