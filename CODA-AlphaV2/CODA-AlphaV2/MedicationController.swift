//
//  MedicationController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class MedicationController: UIViewController {

    // Storyboard variables for user's first name and medications text
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var pdfFieldMed: UITextView!
    
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
    var pdfGathered = ""
    
    override func viewWillDisappear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(pdfGathered, forKey: "savingPDFString")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // filling in medications text
        pdfFieldMed.isUserInteractionEnabled = true
       
        let userDefault = UserDefaults.standard
        userDefault.value(forKey: "savingPDFString")
        
        pdfFieldMed.text = userDefault.value(forKey: "savingPDFString") as? String
        
        if pdfFieldMed.text == ""{
            pdfFieldMed.text = pdfGathered
        } else {
            pdfFieldMed.text = pdfFieldMed.text
            pdfGathered = pdfFieldMed.text
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
    
    // Function to go to home page when button is pressed
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "medHomeSegue", sender: self)
    }
 
    // Function to go to problems list page when button is pressed
    @IBAction func goProblemsButton(_ sender: Any) {
        performSegue(withIdentifier: "medProblemSegue", sender: self)
    }
    
    // Function to go to appointments schedule page when button is pressed
    @IBAction func goAppointmentButton(_ sender: Any) {
        performSegue(withIdentifier: "medAppointmentSegue", sender: self)
    }
    
    // Function to go to what to watch for page when button is pressed
    @IBAction func goWatchButton(_ sender: Any) {
        performSegue(withIdentifier: "medWatchSegue", sender: self)
    }
    
    // Function to go to contact on-call team page when button is pressed
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "medCallSegue", sender: self)
    }
    
    // Function to go to discharge summary page when button is pressed
    @IBAction func goDischargeButton(_ sender: Any) {
        performSegue(withIdentifier: "medDischargeSegue", sender: self)
    }
    
    // Function that tells what view controller to be looking at and passing through user's first name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "medHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "medProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "medAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "medWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "medCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
        } else if segue.identifier == "medDischargeSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
    }
}
