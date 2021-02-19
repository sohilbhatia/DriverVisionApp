//
//  SpeedScrollViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/12/21.
//

import UIKit
import Lottie
class SpeedScrollViewController: UIViewController {

    @IBOutlet var arrowsAni: UIView!
    @IBOutlet var speedAni: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationV =  AnimationView(name: "lf30_editor_dlt2o6em")
        animationV.contentMode = .scaleAspectFit
        self.speedAni.addSubview(animationV)
        animationV.frame = self.speedAni.bounds
        animationV.play(fromProgress: 0,
           toProgress: 1,
           loopMode: LottieLoopMode.repeat(1000),
           completion: { (finished) in
            if finished {
                animationV.play()
            } else {
                animationV.play(fromProgress: 0,
                                       toProgress: 1,
                                       loopMode: LottieLoopMode.repeat(1000),
                                       completion: { (finished) in
                                        if finished {
                                            animationV.play()
                                        } else {
                                            animationV.play()
                                        }
                    })
            }
           })
        let nextV =  AnimationView(name: "arrows")
        nextV.contentMode = .scaleAspectFit
        self.arrowsAni.addSubview(nextV)
        nextV.frame = self.arrowsAni.bounds
        self.arrowsAni.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        nextV.play(fromProgress: 0,
           toProgress: 1,
           loopMode: LottieLoopMode.repeat(1000),
           completion: { (finished) in
            if finished {
                nextV.play()
            } else {
                nextV.play(fromProgress: 0,
                                       toProgress: 1,
                                       loopMode: LottieLoopMode.repeat(1000),
                                       completion: { (finished) in
                                        if finished {
                                            nextV.play()
                                        } else {
                                            nextV.play()
                                        }
                    })
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

