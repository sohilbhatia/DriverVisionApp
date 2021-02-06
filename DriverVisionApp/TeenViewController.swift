//
//  TeenViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/27/20.
//

import UIKit
import Firebase
import Lottie

import CBFlashyTabBarController

var myCode = String()
var key = String()
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
        
        let pre_vc = self.storyboard?.instantiateViewController(identifier: "name_vc") as! NameViewController
        self.view.window?.rootViewController = pre_vc
        self.view.window?.makeKeyAndVisible()
        
        /*
        let mapsVC = MapViewController()
        mapsVC.tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "3440906-48"), tag: 0)
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "118603-48"), tag: 0)
        
        //settingsVC.inverseColor()
        
        mapsVC.view.layoutIfNeeded()
        settingsVC.view.layoutIfNeeded()

        let tabBarController = CBFlashyTabBarController()
        tabBarController.viewControllers = [mapsVC, settingsVC]
//        navigationController?.pushViewController(tabBarController, animated: true)
        self.view.window?.rootViewController = tabBarController
        self.view.window?.makeKeyAndVisible()
 */
        //self.present(tabBarController, animated: true, completion: nil)
        /*
        if let tabbar = (storyboard!.instantiateViewController(withIdentifier: "tab_vc") as? UITabBarController) {
            tabbar.modalTransitionStyle = .crossDissolve
            self.view.window?.rootViewController = tabbar
            self.view.window?.makeKeyAndVisible()
        }
 */
    
        
        
/*
        self.view.window?.rootViewController = next_vc
        self.view.window?.makeKeyAndVisible()
 */

    }
    
    
    @IBOutlet var validateButton: UIButton!
    @IBOutlet var invalidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeField.font = UIFont(name: "Avenir", size: 29)
        codeField.textColor = UIColor.white
        codeField.tintColor = .white
        codeField.textAlignment = .center
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
        
        //let animationV =  AnimationView(name: "lf30_editor_sftuxhry")
        /*
        animationV.contentMode = .scaleAspectFit
        self.connectV.addSubview(animationV)
        animationV.frame = self.connectV.bounds
        animationV.loopMode = .loop
        
        animationV.play()
        */

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        print(self.codeField.text!)
        ref = Database.database().reference()
        //let strSearch = "K"
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
                        /*
                        let checkMarkAnimation =  AnimationView(name: "lf30_editor_q50j0emu")
                        connectV.contentMode = .scaleAspectFit
                        self.connectV.addSubview(checkMarkAnimation)
                        checkMarkAnimation.frame = self.AVView.bounds
                        */
                        animationV = AnimationView(name: "lf30_editor_q50j0emu")
                        animationV.contentMode = .scaleAspectFit
                        self.connectV.addSubview(animationV)
                        animationV.frame = self.connectV.bounds
                        animationV.play()
                        
                        nextButton.isEnabled = true
                        
                       
                        //checkMarkAnimation.play()
                        // the code you put here will be compiled once the animation finishes
                        //let next_vc = self.storyboard?.instantiateViewController(identifier: "map_vc") as!
                        //MapViewController
                        //self.view.window?.rootViewController = next_vc
                        //self.view.window?.makeKeyAndVisible()
                            
                       
                    }
                    /*
                    if (animationV.isAnimationPlaying == true) {
                        myCode = self.codeField.text!
                        self.nextButton.isEnabled = true
                        
                        
                            
                            
                    }
 */
                        //self.invalidLabel.text = "valid code!"
                        
                        
                        
                        
                        
                    
                    //sleep(5)
                    
                    
                }
                
                
                
                
                /*
                for i in dictionary {
                    let code = dictionary[self.codeField.text!]
                    let final = code["code"] as! String
                    if (code == self.codeField.text) {
                        self.invalidLabel.text = "valid code!"
                        myCode = self.codeField.text!
                        self.nextButton.isEnabled = true
                        
                        
                    }
                    else {
                        self.invalidLabel.text = "invalid code!"
                    }
                }
 */
                
            }
            
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
