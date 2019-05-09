//
//  ProblemController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class ProblemController: UIViewController {

    // Storyboard variables for user's first name and problems list text
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var pdfFieldPrb: UITextView!
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(pdfGatheredProblem, forKey: "savingPDFStringProblem")
    }
    
    var finalUsername = ""
    var userValue = ""
    var passback = ""
    var pdfGatheredProblem = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // filling in problems list text
        pdfFieldPrb.isUserInteractionEnabled = true
        
        let userDefault = UserDefaults.standard
        userDefault.value(forKey: "savingPDFStringProblem")
        
        pdfFieldPrb.text = userDefault.value(forKey: "savingPDFStringProblem") as? String
        
        if pdfFieldPrb.text == "" {
            pdfFieldPrb.text = pdfGatheredProblem
        } else {
            pdfFieldPrb.text = pdfFieldPrb.text
            pdfGatheredProblem = pdfFieldPrb.text
        }
        
        // filling in user's first name
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.orange]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    // Function to go to home page when button is pressed
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "prbHomeSegue", sender: self)
    }
    
    // Function to go to medications page when button is pressed
    @IBAction func goMedButton(_ sender: Any) {
        performSegue(withIdentifier: "prbMedSegue", sender: self)
    }
    
    // Function to go to appointments schedule page when button is pressed
    @IBAction func goAppointmentButton(_ sender: Any) {
        performSegue(withIdentifier: "prbAppointmentSegue", sender: self)
    }
    
    // Function to go to what to watch for page when button is pressed
    @IBAction func goWatchButton(_ sender: Any) {
        performSegue(withIdentifier: "prbWatchSegue", sender: self)
    }
    
    // Function to go to contact on-call team page when button is pressed
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "prbCallSegue", sender: self)
    }
    
    // Function to go to discharge summary page when button is pressed
    @IBAction func goDischargeButton(_ sender: Any) {
        performSegue(withIdentifier: "prbDischargeSegue", sender: self)
    }
    
    // Function that tells what view controller to be looking at and passing through user's first name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "prbHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "prbMedSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "prbAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "prbWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "prbCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "prbDischargeSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
    }
}
