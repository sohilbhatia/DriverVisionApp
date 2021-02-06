//
//  PreViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/2/21.
//

import UIKit
import Lottie

class PreViewController: UIViewController {

   
    @IBOutlet var aniView: UIView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var dateTxt: UILabel!
    override func viewDidLoad() {
        
        var aniv =  AnimationView(name: "car")
        super.viewDidLoad()
        mainTitle.text = "Hello " + name + "!"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

