//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class CallController: UIViewController {
    
    //@IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    
    
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
    
    func makeAPhoneCall()  {
        //Sams number
        //PDF SCRAPER THE NUMBER OR FROM DB
        let url: NSURL = URL(string: "TEL://8028472284")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    var finalUsername = ""
    var passback = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
        
        
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
    
    @IBAction func callTeam(_ sender: Any) {
    
        self.makeAPhoneCall()
    
    }
    //@IBAction func goHome(_ sender: Any) {
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "callHomeSegue", sender: self)
    }
   
    @IBAction func goMedButton(_ sender: Any) {
         performSegue(withIdentifier: "callMedSegue", sender: self)
    }
    @IBAction func goProblemButton(_ sender: Any) {
         performSegue(withIdentifier: "callProblemSegue", sender: self)
    }
    @IBAction func goAppointmentButton(_ sender: Any) {
         performSegue(withIdentifier: "callAppointmentSegue", sender: self)
    }
    @IBAction func goWatchButton(_ sender: Any) {
         performSegue(withIdentifier: "callWatchSegue", sender: self)
    }
    @IBAction func goDischargeButton(_ sender: Any) {
         performSegue(withIdentifier: "callDischargeSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "callProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "callAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "callWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "callMedSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "callDischargeSegue" {
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
