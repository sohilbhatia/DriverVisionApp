//
//  MapViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/28/20.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications
import Firebase
import SwiftUI


var overSpeedPercentage = 0.0
var trynow = 0.0
var continueAlerts = false
var countStill = 0
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
var newLoc = CLLocation()
    

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var ref: DatabaseReference!
    @IBOutlet var map: MKMapView!
    @IBOutlet var speed: UILabel!
    @IBOutlet var speedlimit: UILabel!
    @IBOutlet var displaySpeed: UILabel!
    @IBOutlet var displayLimit: UILabel!
    
    var SPDlim = Int()
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        
        guard let mostRecentLocation = locations.last else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.allowsBackgroundLocationUpdates = true
        manager.startUpdatingLocation()
        manager.startMonitoringSignificantLocationChanges()
        //newLoc = location.speed
        newLoc = location
        
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        map.setRegion(region, animated: true)
        self.map.layer.shadowColor = UIColor.black.cgColor
        self.map.layer.shadowOpacity = 0.09
        self.map.layer.shadowOffset = CGSize(width: 0, height: 1.1)
        self.map.showsUserLocation = true
        var finalSpeed = location.speed
        if (finalSpeed < 0) {
            finalSpeed = 0
        }
        //speed.text = "Current Speed: " + String(round((speedTest * 2.24)*10) / 10) + " MPH"
        displaySpeed.text = String(round((speedTest * 2.24)*10) / 10)
        
        //let newLoc = String(location)
        
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
        displayLimit.text = String(speedlim)
        
        
        
        print(location)
        
        if ((speedTest > 1.5) && (speedlim > 0)) {
            print("Drive Started")
            continueAlerts = true
            //print("SPEED TEST - " + String(continueAlerts))
        }
            if (continueAlerts == true) {
                if(((Int(speedlim) / 2) - Int(speedTest)) < 0) {
                    //print("Status: Alert")
                    
                    //numberOfAlerts.remove(at: 1)
                    
                    numberOfAlerts.append("1")
                }
                else if(speedTest <= 1.5) {
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
                            for i in numberOfAlerts {
                                if (i=="1") {
                                    if(countStill >= 240) {
                                        print("COUNT AT 10 ")
                                        /*
                                        let content = UNMutableNotificationContent()
                                        content.title = "Drive Session Ended"
                                        content.body = "You went over the speedlimit " + String(Int(overSpeedPercentage)) + "% of the time."
                                        
                                        content.sound = UNNotificationSound.default
                                        
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                                        
                                        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
                                        
                                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                 */
                                        callNoti(value: continueAlerts, speedPercentage: overSpeedPercentage)
                                        
                                        
                                        continueAlerts = false
                                        countStill = 0
                                        //numberOfAlerts.removeAll()
                                        
                                        if (isRegDriver == false) {
                                            self.ref.child("codes").child(myCode).child("messages").setValue(["message": "Your teenager went over the speedlimit " + String(Int(overSpeedPercentage)) + "% of the time."])
                                        }
                                        print("STILL - " + String(continueAlerts))
                                        
                                        
                                    }
                                }
                                
                            }
                        
                        }
                            
                        }
                    
                }
        
        
    }
    //run app when
    

    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        
        //speed.text = "Current Speed: " + String(round((location.speed * 2.24)*100) / 100) + "mph"
        
        self.map.showsUserLocation = true
        /* https://dev.virtualearth.net/REST/v1/Routes/SnapToRoad?points=47.685643,-122.126544&includeTruckSpeedLimit=true&IncludeSpeedLimit=true&speedUnit=MPH&travelMode=driving&key=AgqimMOPfDALglebExqcY5DFuVFrl1TE75EPl6jpYZvKlHR3oMQCDjGxgok-3Dwb
        */
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
        print("YOUR SPEED LIMIT IS " + String(speedlim))
        print("Current Speed: " + String(round((speedTest * 2.24)*10) / 10) + " MPH")
        speedlimit.text = "Speed Limit: " + String(speedlim) + " MPH"
        speed.text = "Current Speed: " + String(round((speedTest * 2.24)*10) / 10) + " MPH"
        print((Int(speedlim) / 2) - Int(speedTest))
        // ((Int(speedlim) / 2) - Int(speedTest))
        //numberOfAlerts.remove(at: 0)
        //numberOfAlerts.remove(at: 1)
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
       /*

        if(Int(location.speed) > self.SPDlim) {
            alertTest.isHidden = false
        }
        
        if(Int(location.speed) < self.SPDlim) {
            alertTest.isHidden = true
        }
        */

    // Do any additional setup after loading the view.
}
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        
        map.layer.cornerRadius = 20.0;
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.allowsBackgroundLocationUpdates = true
        ref = Database.database().reference()
        
        UserDefaults.standard.set(true, forKey: "codeValid")
        UserDefaults.standard.synchronize()
        
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")

            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
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
func callNoti(value: Bool, speedPercentage: Double) {
    print("FROM NOTIFICATION - " + String(value))
    if (value == true) {
        let content = UNMutableNotificationContent()
        content.title = "Drive Session Ended"
        content.body = "You went over the speedlimit " + String(Int(speedPercentage)) + "% of the time."
        
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
}
