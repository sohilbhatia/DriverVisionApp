//
//  TeenViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/27/20.
//

import UIKit
import Firebase
import Lottie
import SwiftyUserDefaults

import CBFlashyTabBarController

var myCode = String()
var key = String()
/*
extension DefaultsKeys {
    static let parentCode = DefaultsKey<String?>{ .init("parentCode") }
    static let islogin = DefaultsKey<Bool?> { .init("islogin") }
}
*/
var defaults = UserDefaults.standard
class TeenViewController: UIViewController {
    var animationV =  AnimationView(name: "lf30_editor_sftuxhry")
    var ref: DatabaseReference!
    var loCheck = 0
    @IBOutlet var connectV: UIView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var codeField: UITextField! {
        didSet {
                let redPlaceholderText = NSAttributedString(string: "Ex. (AE42)",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                
                codeField.attributedPlaceholder = redPlaceholderText
            }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
    
        UserDefaults.standard.set(self.codeField.text!, forKey: "code")
        UserDefaults.standard.synchronize()
        let pre_vc = self.storyboard?.instantiateViewController(identifier: "root_vc") as! RootViewController
        self.view.window?.rootViewController = pre_vc
        self.view.window?.makeKeyAndVisible()
        print(codeField.text!)
        myCode = codeField.text!
        

    }
    
    
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var invalidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeField.font = UIFont(name: "Avenir", size: 29)
        codeField.textColor = UIColor.white
        codeField.tintColor = .white
        codeField.textAlignment = .center
        
        self.codeField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        codeField.attributedPlaceholder = NSAttributedString(string: "Ex. A243", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: codeField.frame.height+2, width: codeField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        codeField.borderStyle = UITextField.BorderStyle.none
        codeField.layer.addSublayer(bottomLine)
        
        
        validateButton.backgroundColor = UIColor.white
        validateButton.layer.cornerRadius = 25.0
        validateButton.tintColor = UIColor.white
        
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 25.0
        nextButton.tintColor = UIColor.white
        nextButton.isEnabled = false
        
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        print(self.codeField.text!)
        ref = Database.database().reference()
        //let strSearch = "K"
        let userCode = (self.codeField.text)!.uppercased()
        ref.child("codes").observe(.value, with: { [self](snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                print(dictionary)
                
                if ((dictionary[self.codeField.text!]) == nil) {
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.07
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.codeField.center.x - 10, y: codeField.center.y))
                    animation.toValue = NSValue(cgPoint: CGPoint(x: codeField.center.x + 10, y: codeField.center.y))

                    codeField.layer.add(animation, forKey: "position")
                }
                else {
                    let final = dictionary[self.codeField.text!] as! [String:Any]
                    
                    if (((final["code"]) as! String) == self.codeField.text!) {
                        UserDefaults.standard.set(self.codeField.text!, forKey: "code")
                        UserDefaults.standard.synchronize()
                        animationV = AnimationView(name: "lf30_editor_q50j0emu")
                        animationV.contentMode = .scaleAspectFit
                        self.connectV.addSubview(animationV)
                        animationV.frame = self.connectV.bounds
                        animationV.play()
                        self.ref.child("codes").child(self.codeField.text!).updateChildValues(["teenToken": Messaging.messaging().fcmToken!])
                        nextButton.isEnabled = true
                        
                       
                    }
                    
                    
                }
                
                
            }
            
        })
    }
    

}
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

