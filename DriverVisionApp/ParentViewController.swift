//
//  ParentViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/27/20.
//

import UIKit
import Firebase
import FirebaseMessaging
var finalCode = String()
//gitest
class ParentViewController: UIViewController {
    @IBOutlet var codeNext: UIButton!
    
    
    let uppercaseLetters = (65...90).map {String(UnicodeScalar($0))}

    

    func randomLetter() -> String { 
        return uppercaseLetters.randomElement()!
    }

    @IBAction func nextMove(_ sender: Any) {
        let pre_vc = self.storyboard?.instantiateViewController(identifier: "parent_vc") as! ParentHomeViewController
        self.view.window?.rootViewController = pre_vc
        self.view.window?.makeKeyAndVisible()
    }
    @IBOutlet var generatedCodeLabel: UILabel!
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        codeNext.backgroundColor = UIColor.white
        codeNext.layer.cornerRadius = 25.0
        codeNext.tintColor = UIColor.white
        
       
        self.hideKeyboardWhenTappedAround()
        
        ref = Database.database().reference()
        super.viewDidLoad()
        let randomInt1 = Int.random(in: 0..<9)
        let randomString1 = randomLetter()
        let randomInt2 = Int.random(in: 0..<9)
        let randomString2 = randomLetter
        
        let generatedParentCode = randomString1 + String(randomInt1) + randomString2() + String(randomInt2)
        self.ref.child("codes").child(generatedParentCode).updateChildValues(["code": generatedParentCode])
        self.ref.child("codes").child(generatedParentCode).updateChildValues(["parentToken": Messaging.messaging().fcmToken!])
            
        generatedCodeLabel.text = generatedParentCode
        finalCode = generatedParentCode
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
