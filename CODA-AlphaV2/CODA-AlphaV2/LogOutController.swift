//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class LogOutController: UIViewController {
    
    // Storyboard label variable for user's first name
    @IBOutlet weak var userLbl: UILabel!
    
    @IBDesignable class DesignableView: UIView {
        @IBInspectable var gradientColor1: UIColor = UIColor.white {
            didSet {
                self.setGradient()
            }
        }
        
        @IBInspectable var gradientColor2: UIColor = UIColor.white {
            didSet {
                self.setGradient()
            }
        }
        
        @IBInspectable var gradientStartPoint: CGPoint = .zero {
            didSet {
                self.setGradient()
            }
        }
        
        @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
            didSet {
                self.setGradient()
            }
        }
        
        private func setGradient() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
            gradientLayer.startPoint = self.gradientStartPoint
            gradientLayer.endPoint = self.gradientEndPoint
            gradientLayer.frame = self.bounds
            if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
                topLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
    
    var finalUsername = ""
    var passback = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // filling in user's first name
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    // Function to go to home page when button is pressed
    @IBAction func goHome(_ sender: Any) {
    performSegue(withIdentifier: "logOutHomeSegue", sender: self)
    }
    
    // Function to go to login page when button is pressed
    @IBAction func logOut(_ sender: Any) {
        performSegue(withIdentifier: "logOutSegue", sender: self)
    }
    
    // Function that tells what view controller to be looking at and passing through user's first name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOutHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        }
    }
}
