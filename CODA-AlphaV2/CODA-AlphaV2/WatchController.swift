//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class WatchController: UIViewController {
    
    // Storyboard variables for user's first name and what to watch for text
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var pdfFieldWtch: UITextView!
    
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
        userDefault.set(pdfGatheredWatch, forKey: "savingPDFStringWatch")
    }
    
    var finalUsername = ""
    var passback = ""
    var pdfGatheredWatch = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfFieldWtch.isUserInteractionEnabled = true
        
        // filling in what to watch for text
        let userDefault = UserDefaults.standard
        userDefault.value(forKey: "savingPDFStringWatch")
        
        pdfFieldWtch.text = userDefault.value(forKey: "savingPDFStringWatch") as? String
        
        if pdfFieldWtch.text == "" {
            pdfFieldWtch.text = pdfGatheredWatch
        } else {
            pdfFieldWtch.text = pdfFieldWtch.text
            pdfGatheredWatch = pdfFieldWtch.text
        }
        
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
    
    // Function to go to home page button is when pressed
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "wtchHomeSegue", sender: self)
    }
    
    // Function to go to medications page when button is pressed
    @IBAction func goMedicationButton(_ sender: Any) {
        performSegue(withIdentifier: "wtchMedSegue", sender: self)
    }
    
    // Function to go to problems list page when button is pressed
    @IBAction func goProblemButton(_ sender: Any) {
        performSegue(withIdentifier: "wtchProblemSegue", sender: self)
    }
    
    // Function to go to appointments schedule page when button is pressed
    @IBAction func goAppointmentButton(_ sender: Any) {
        performSegue(withIdentifier: "wtchAppointmentSegue", sender: self)
    }
    
    // Function to go to contact on-call team page when button is pressed
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "wtchCallSegue", sender: self)
    }
    
    // Function to go to discharge summary page when button is pressed
    @IBAction func goDischargeButton(_ sender: Any) {
        performSegue(withIdentifier: "wtchDischargeSegue", sender: self)
    }
    
    // Function that tells what view controller to be looking at and passing through user's first name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wtchHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "wtchProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "wtchAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "wtchMedSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "wtchCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "wtchDischargeSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
    }
}
