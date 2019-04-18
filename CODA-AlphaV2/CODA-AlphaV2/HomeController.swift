//
//  HomeController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit


class HomeController: UIViewController, UITextFieldDelegate {
    
    // Change the username
    @IBOutlet weak var usrnameLbl: UILabel!
    
    
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
    
    @IBOutlet weak var medButtonAtt: UIButton!
    @IBOutlet weak var prbButtonAtt: UIButton!
    @IBOutlet weak var apptButtonAtt: UIButton!
    @IBOutlet weak var wtchButtonAtt: UIButton!
    @IBOutlet weak var callButtonAtt: UIButton!
    @IBOutlet weak var dchButtonAtt: UIButton!
    
    var userValue: String!
    var returnValue: String!
    var usernameText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        //view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 1)
        
        //set usrname feild
//        let user = ""
//        let controller = ViewController()
//        let usrname = controller.getUsername()
        //print(usrname)
        
        usrnameLbl.text = "Welcome: " + userValue
        
        // Create methods to move display around for keyboard use
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        medButtonAtt.layer.cornerRadius = 30
        medButtonAtt.clipsToBounds = true
        
        prbButtonAtt.layer.cornerRadius = 30
        prbButtonAtt.clipsToBounds = true
        
        apptButtonAtt.layer.cornerRadius = 30
        apptButtonAtt.clipsToBounds = true
        
        wtchButtonAtt.layer.cornerRadius = 30
        wtchButtonAtt.clipsToBounds = true
        
        callButtonAtt.layer.cornerRadius = 30
        callButtonAtt.clipsToBounds = true
        
        dchButtonAtt.layer.cornerRadius = 30
        dchButtonAtt.clipsToBounds = true
        
    }
    
    
    @IBAction func medButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "medSegue", sender: self)
    }
    @IBAction func prbButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "prbSegue", sender: self)
    }
    @IBAction func aptButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "aptSegue", sender: self)
    }
    @IBAction func wtchButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "wtchSegue", sender: self)
    }
    @IBAction func callButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "callSegue", sender: self)
    }
    @IBAction func dchrgButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "dchrgSegue", sender: self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        usernameText = usrnameLbl.text!
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "medSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = self.usernameText
        } else if segue.identifier == "prbSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = self.usernameText
        }
        else if segue.identifier == "aptSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = self.usernameText
        }
        else if segue.identifier == "wtchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = self.usernameText
        }
        else if segue.identifier == "callSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = self.usernameText
        }
        else if segue.identifier == "dchrgSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = self.usernameText
        }
        else if segue.identifier == "logoutSegue" {
            let vc = segue.destination as! LogOutController
            vc.finalUsername = self.usernameText
        }
        
        
        
    }
    
    //Move our view back out of the keyboard view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    // This will move our display up so we can edit the textfield easier
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    // This will move our display back to normal
    @objc func keyboardWillHide(sender: NSNotification){
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    
    
    
    
    
}

