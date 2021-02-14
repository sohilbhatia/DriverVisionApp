//
//  SwipeViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/6/21.
//

import UIKit
import Lottie

class SwipeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var images: [String] = ["lf30_editor_dlt2o6em", "lf30_editor_stpykcmy", "lf30_editor_46ulwchd"]
    var frame = CGRect(x:0, y:0, width:0, height: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width
                 * CGFloat(index)
            frame.size = scrollView.frame.size
            let aniView = UIView(frame: frame)
            var myAnimation =  AnimationView()
            myAnimation =  AnimationView(name: images[index])
            myAnimation.contentMode = .scaleAspectFit
            aniView.addSubview(myAnimation)
            myAnimation.frame = aniView.bounds
            myAnimation.play()
            
            self.scrollView.addSubview(myAnimation)
            
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
