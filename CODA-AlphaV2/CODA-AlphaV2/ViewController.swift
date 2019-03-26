//
//  ViewController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/5/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    // urls for both login and register
    let URL_USER_LOGIN = "http://snguon.w3.uvm.edu/cs295d/login.php"
    let URL_USER_REGISTER = "http://snguon.w3.uvm.edu/cs295d/register.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard

    // Initializing all the items on login page
    @IBOutlet weak var usernameLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        //getting the username and password
        let parameters: Parameters=[
            "username":usernameLogin.text!,
            "password":passwordLogin.text!
        ]
        
        //making a post request
        AF.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPass = user.value(forKey: "password") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "email")
                        self.defaultValues.set(userPass, forKey: "password")
                        
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        //error message in case of invalid credential
                        let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        //self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    @IBAction func goToRegistrationButtonPressed(_ sender: Any) {
    }
    
    
    // Initializing all items on reigster page
    @IBOutlet weak var usernameRegister: UITextField!
<<<<<<< HEAD
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
=======
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var passwordConfrimRegister: UITextField!
>>>>>>> parent of 33401ba... refractor register
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        //creating parameters for the post request
        let parameters: Parameters=[
            "username":usernameRegister.text!,
            "password":emailRegister.text!,
            //"email":textFieldEmail.text!
        ]
        
        //Sending http post request
        AF.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    //self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                }
        }
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

