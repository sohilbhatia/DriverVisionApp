//
//  NameViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/1/21.
//

import UIKit
var name = String()
class NameViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    //@IBOutlet var nameField: UITextField!
    @IBOutlet var nxtBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        nxtBtn.isEnabled = true
        nameField.font = UIFont(name: "Avenir", size: 29)
        nameField.textColor = UIColor.white
        nameField.tintColor = .white
        nameField.textAlignment = .center
        nameField.attributedPlaceholder = NSAttributedString(string: "Your Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        self.nameField.autocapitalizationType = .words
        nameField.autocorrectionType = .no
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: nameField.frame.height+2, width: nameField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        nameField.borderStyle = UITextField.BorderStyle.none
        nameField.layer.addSublayer(bottomLine)
        nxtBtn.backgroundColor = UIColor.white
        nxtBtn.layer.cornerRadius = 25.0
        nxtBtn.tintColor = UIColor.white
        
        let pre_vc = self.storyboard?.instantiateViewController(identifier: "name_vc") as! NameViewController
        self.view.window?.rootViewController = pre_vc
        self.view.window?.makeKeyAndVisible()

        // Do any additional setup after loading the view.
    }
    @IBAction func nxtClick(_ sender: Any) {
        if (nameField.text == "") {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.nameField.center.x - 10, y: nameField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: nameField.center.x + 10, y: nameField.center.y))

            nameField.layer.add(animation, forKey: "position")
        }
        else {
            name = nameField.text!
            print(defaults.value(forKey: "code")!)
            //checkjh
            UserDefaults.standard.set(true, forKey: "isLogged")
            let g_vc = self.storyboard?.instantiateViewController(identifier: "map_vc") as! MapViewController
            self.view.window?.rootViewController = g_vc
            self.view.window?.makeKeyAndVisible()
        }
        
    }

}

