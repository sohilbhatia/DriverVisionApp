//
//  RootViewController.swift
//  DriverVisionApp
//
//  Created by Sohil Bhatia on 2/12/21.
//

import UIKit
public var fullCheck = true
class RootViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "purple_vc")
        let vc2 = sb.instantiateViewController(withIdentifier: "orange_vc")
        let vc3 = sb.instantiateViewController(withIdentifier: "indigo_vc")
        let vc5 = sb.instantiateViewController(withIdentifier: "name_vc")
        let vc6 = sb.instantiateViewController(withIdentifier: "launch_vc")
        let vc4 = sb.instantiateViewController(withIdentifier: "g_vc")
        
        
        return [vc1, vc2, vc3, vc6, vc5, vc4]
        
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
 
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
       // return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

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
