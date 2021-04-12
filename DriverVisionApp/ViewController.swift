//
//  ViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/26/20.
//

import UIKit
import Firebase
import SwiftyUserDefaults
var isRegDriver = false
class ViewController: UIViewController {


    @IBOutlet var driverAction: UIButton!
    @IBOutlet var teenageButton: UIButton!
    @IBOutlet var parentButtob: UIButton!
    @IBOutlet var driverButton: UIButton!
    @IBAction func regDriver(_ sender: Any) {
        isRegDriver = true
        let pre_vc = self.storyboard?.instantiateViewController(identifier: "root_vc") as! RootViewController
        self.view.window?.rootViewController = pre_vc
        self.view.window?.makeKeyAndVisible()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue("AG32", forKey: "code")
        UserDefaults.standard.synchronize()
        print("HERE IS THE DEFAULT:")
        print(defaults.value(forKey: "code")!)
        self.view.layoutIfNeeded()
        if (UserDefaults.standard.bool(forKey: "codeValid") == true) {
            print("FRANCHISE")
            let mapC = self.storyboard?.instantiateViewController(identifier: "map_vc") as! MapViewController
            self.view.window?.rootViewController = mapC
            self.view.window?.makeKeyAndVisible()
        }
 
        teenageButton.backgroundColor = UIColor.white
        teenageButton.layer.cornerRadius = 25.0
        teenageButton.tintColor = UIColor.white
        
        parentButtob.backgroundColor = UIColor.white
        parentButtob.layer.cornerRadius = 25.0
        parentButtob.tintColor = UIColor.white
        
        driverButton.backgroundColor = UIColor.white
        driverButton.layer.cornerRadius = 25.0
        driverButton.tintColor = UIColor.white
        
        
    }


}

