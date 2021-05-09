//
//  LaunchViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 4/27/21.
//

import UIKit
import Lottie
class LaunchViewController: UIViewController {

    @IBOutlet var openView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var animationV =  AnimationView(name: "lf30_editor_q50j0emu")
        animationV = AnimationView(name: "lf30_editor_q50j0emu")
        animationV.contentMode = .scaleAspectFit
        self.openView.addSubview(animationV)
        animationV.frame = self.openView.bounds
        animationV.play(fromProgress: 0,
                               toProgress: 1,
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
