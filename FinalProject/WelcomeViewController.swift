//
//  WelcomeViewController.swift
//  FinalProject
//
//  Created by Berry on 3/9/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    var initialTouchPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.minimumNumberOfTouches = 2
        swipeGesture.maximumNumberOfTouches = 2
        view.addGestureRecognizer(swipeGesture)
        
        image.layer.cornerRadius = image.frame.size.width / 2
    }
    
    @objc func handleSwipeGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            initialTouchPoint = gesture.location(in: view)
        } else if gesture.state == .changed {
            // Calculate the distance of the pan
            let xDistance = gesture.location(in: view).x - initialTouchPoint.x
            let yDistance = gesture.location(in: view).y - initialTouchPoint.y

            // Check if the pan meets the minimum distance requirement
            if abs(xDistance) > 100 && abs(yDistance) < 100 {
                if xDistance > 0 {
                    // Swiped right
                } else {
                    // Swiped left
                    tabBarController?.selectedIndex = 1

                }
            }
        }
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
