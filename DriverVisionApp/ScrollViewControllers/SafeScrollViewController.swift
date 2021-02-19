//
//  SafeScrollViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/12/21.
//

import UIKit
import Lottie
class SafeScrollViewController: UIViewController {

    @IBOutlet var safeAni: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var animationV =  AnimationView(name: "lf30_editor_wmagglsb")
        animationV = AnimationView(name: "lf30_editor_wmagglsb")
        animationV.contentMode = .scaleAspectFit
        self.safeAni.addSubview(animationV)
        animationV.frame = self.safeAni.bounds
        animationV.play(fromProgress: 0,
                               toProgress: 100,
                               loopMode: LottieLoopMode.loop,
                               completion: { (finished) in
                                if finished {
                                  print("Animation Complete, Start second one")
                                } else {
                                    animationV.play()
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
