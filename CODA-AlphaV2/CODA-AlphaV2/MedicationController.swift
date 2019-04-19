//
//  MedicationController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class MedicationController: UIViewController {

    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var pdfFieldMed: UITextView!
    
    @IBDesignable class DesignableView: UIView
    {
        @IBInspectable var gradientColor1: UIColor = UIColor.white {
            didSet{
                self.setGradient()
            }
        }

        @IBInspectable var gradientColor2: UIColor = UIColor.white {
            didSet{
                self.setGradient()
            }
        }

        @IBInspectable var gradientStartPoint: CGPoint = .zero {
            didSet{
                self.setGradient()
            }
        }

        @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
            didSet{
                self.setGradient()
            }
        }

        private func setGradient()
        {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
            gradientLayer.startPoint = self.gradientStartPoint
            gradientLayer.endPoint = self.gradientEndPoint
            gradientLayer.frame = self.bounds
            if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
            {
                topLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
    
    var finalUsername = ""
    var passback = ""
    var pdfGathered = ""
//    var pdfSaved = String()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(pdfGathered, forKey: "savingPDFString")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfFieldMed.isUserInteractionEnabled = false
       
        let userDefault = UserDefaults.standard
        userDefault.value(forKey: "savingPDFString")
        
        pdfFieldMed.text = userDefault.value(forKey: "savingPDFString") as? String
        
        if pdfFieldMed.text == ""{
            pdfFieldMed.text = pdfGathered
//            print("EMPTY!")
        }else{
            pdfFieldMed.text = pdfFieldMed.text
            pdfGathered = pdfFieldMed.text
//            print("FILLED")
        }
        
        
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
//
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        //view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 1)
        
        
//        let range1 = finalUsername.characters.index(finalUsername.startIndex, offsetBy: 9)..<finalUsername.endIndex
//        finalUsername = String(finalUsername[range1])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goHomeButton(_ sender: Any) {
    performSegue(withIdentifier: "medHomeSegue", sender: self)
    }
 
    @IBAction func goProblemsButton(_ sender: Any) {
        performSegue(withIdentifier: "medProblemSegue", sender: self)
    }
    @IBAction func goAppointmentButton(_ sender: Any) {
        performSegue(withIdentifier: "medAppointmentSegue", sender: self)
    }
    @IBAction func goWatchButton(_ sender: Any) {
        performSegue(withIdentifier: "medWatchSegue", sender: self)
    }
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "medCallSegue", sender: self)
    }
    @IBAction func goDischargeButton(_ sender: Any) {
        performSegue(withIdentifier: "medDischargeSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "medHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "medProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "medAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "medWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "medCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "medDischargeSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
//        let vc = segue.destination as! HomeController
//
//        vc.userValue = self.finalUsername
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
