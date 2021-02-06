//
//  ViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/26/20.
//

import UIKit
import Firebase
class ViewController: UIViewController {


    @IBOutlet var teenageButton: UIButton!
    @IBOutlet var parentButtob: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        teenageButton.backgroundColor = UIColor.white
        teenageButton.layer.cornerRadius = 25.0
        teenageButton.tintColor = UIColor.white
        
        parentButtob.backgroundColor = UIColor.white
        parentButtob.layer.cornerRadius = 25.0
        parentButtob.tintColor = UIColor.white
        
        
    }


}

