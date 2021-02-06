//
//  ParentViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 12/27/20.
//

import UIKit
import Firebase
var finalCode = String()
class ParentViewController: UIViewController {
    let uppercaseLetters = (65...90).map {String(UnicodeScalar($0))}

    func randomLetter() -> String {
        return uppercaseLetters.randomElement()!
    }
    @IBOutlet var generatedCodeLabel: UILabel!
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        let randomInt1 = Int.random(in: 0..<9)
        let randomString1 = randomLetter()
        let randomInt2 = Int.random(in: 0..<9)
        let randomString2 = randomLetter
        
        let generatedParentCode = randomString1 + String(randomInt1) + randomString2() + String(randomInt2)
        self.ref.child("codes").child(generatedParentCode).setValue(["code": generatedParentCode])
            
        generatedCodeLabel.text = generatedParentCode
        finalCode = generatedParentCode
        // Do any additional setup after loading the view.
    }
    @IBAction func nextAction(_ sender: Any) {
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
