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
    var userValue: String!
    var returnValue: String!
    var usernameText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //set usrname feild
//        let user = ""
//        let controller = ViewController()
//        let usrname = controller.getUsername()
        //print(usrname)
        
        usrnameLbl.text = "Welcome: " + userValue
        
        // Create methods to move display around for keyboard use
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
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
