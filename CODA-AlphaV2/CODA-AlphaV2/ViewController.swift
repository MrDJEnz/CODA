//
//  ViewController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/5/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // Initializing all the items on login page
    @IBOutlet weak var usernameLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    @IBAction func goToRegistrationButtonPressed(_ sender: Any) {
    }
    
    
    // Initializing all items on reigster page
    @IBOutlet weak var usernameRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var passwordConfrimRegister: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: Any) {
    }
    @IBAction func returnToLoginButtonPressed(_ sender: Any) {
    }
    
    
    
    //Move our view back out of the keyboard view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create methods to move display around for keyboard use
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.

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

