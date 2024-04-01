//
//  AccountViewController.swift
//  FinalProject
//
//  Created by Berry on 3/9/24.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var initialTouchPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image.layer.cornerRadius = image.frame.size.width / 2
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.minimumNumberOfTouches = 2
        swipeGesture.maximumNumberOfTouches = 2
        view.addGestureRecognizer(swipeGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameField.text = userInstance.name
        phoneField.text = userInstance.phone
        emailField.text = userInstance.email
    }
    
    @IBAction func nameEditingChanged(_ sender: Any) {
        userInstance.name = nameField.text!
    }
    
    @IBAction func phoneEditingChanged(_ sender: UITextField) {
        userInstance.phone = phoneField.text!
    }
    
    @IBAction func emailEditingChanged(_ sender: Any) {
        userInstance.email = emailField.text!
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
                    tabBarController?.selectedIndex = 3
                } else {
                    // Swiped left

                }
            }
        }
    }

}
