//
//  ViewController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/5/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    // urls for both login and register
    let URL_USER_LOGIN = "http://snguon.w3.uvm.edu/cs295d/login.php"
    let URL_USER_REGISTER = "http://snguon.w3.uvm.edu/cs295d/register.php"

    // Initializing all the items on login page
    @IBOutlet weak var usernameLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    @IBOutlet weak var lgButtonAtt: UIButton!
    @IBOutlet weak var rgButtonAtt: UIButton!
    
    @IBOutlet weak var rgRgButtonAtt: UIButton!
    @IBOutlet weak var lgRgButtonAtt: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!
    
    // Biometrics
    let touchMe = BiometricIDAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lgButtonAtt != nil{
        lgButtonAtt.layer.cornerRadius = 10
        lgButtonAtt.clipsToBounds = true
        
        rgButtonAtt.layer.cornerRadius = 10
        rgButtonAtt.clipsToBounds = true
        }
        if rgRgButtonAtt != nil{
        rgRgButtonAtt.layer.cornerRadius = 10
        rgRgButtonAtt.clipsToBounds = true
        
        lgRgButtonAtt.layer.cornerRadius = 10
        lgRgButtonAtt.clipsToBounds = true
        }
        if passwordLogin != nil{
            passwordLogin.isSecureTextEntry = true
        }
        if confirmPasswordRegister != nil{
            confirmPasswordRegister.isSecureTextEntry = true
        }
        if passwordRegister != nil{
            passwordRegister.isSecureTextEntry = true
        }
        
        // Create methods to move display around for keyboard use
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if touchIDButton != nil{
            touchIDButton.isHidden = !touchMe.canEvaluatePolicy()
        
        
        switch touchMe.biometricType() {
        case .faceID:
            touchIDButton.setImage(UIImage(named: "FaceIcon"),  for: .normal)
        default:
            touchIDButton.setImage(UIImage(named: "Touch-icon-lg"),  for: .normal)
        }
        }
    }
    
    // Function that allows for automatic Face ID or Touch ID login when app is opened, commented out for the moment
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let touchBool = touchMe.canEvaluatePolicy()
//        if touchBool {
//            touchIDLoginAction()
//        }
//    }
    
    // Function that passes through the user's first name to the home page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePage" {
            let vc = segue.destination as! HomeController
            let userDefault = UserDefaults.standard
            vc.userValue = userDefault.value(forKey: "firstName") as? String
        }
    }
    
    // function that will login the user if the button is pressed
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        // getting the username and password
        let parameters: Parameters=[
            "username":usernameLogin.text!,
            "password":passwordLogin.text!
        ]
    
        // error checking if user filled in username and password correctly
        // show alerts accordingly if false
        if (usernameLogin.text == nil || (usernameLogin.text?.isEmpty)!) {
            //showAlertError("Username required", message: "")
            let alertController = UIAlertController(title: "USERNAME NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Username needed!")
            return
        }
        if (passwordLogin.text == nil || (passwordLogin.text?.isEmpty)!) {
            //showAlertError("Password required", message: "")
            let alertController = UIAlertController(title: "PASSWORD NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Password needed!")
            return
        }

        // setting an admin account to use for quick access/testing purposes
        if usernameLogin.text == "ADMIN" && passwordLogin.text == "PASSWORD"{
            let fname1 = usernameLogin.text
            let userDefault = UserDefaults.standard
            userDefault.set(fname1, forKey:"firstName")
            self.performSegue(withIdentifier: "homePage", sender: self);
        }
        
        // making a post request
        // basically take in the parameters (username and password) we specify and
        // see if it compares to a username and password combo on the database
        AF.request(URL_USER_LOGIN, method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
                (response) in
                // printing response for testing purposes
            print(response);
            
            // error checking if the PHP echoed back from the site has a true
            // error message, if so, then the username or password is incorrect
            // else, continue to the home page
            if ((response.value?.contains("true"))!) {
                let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
            } else {
                var fname = response.description
                fname = String(fname.dropFirst(54))
                fname = String(fname.dropLast(3))
                print("Firstname: "+fname+"\n")
                let userDefault = UserDefaults.standard
                userDefault.set(fname, forKey:"firstName")
                self.performSegue(withIdentifier: "homePage", sender: self);
            }
        }
    }
    
    // Segue back to the register screen
    @IBAction func goToRegistrationButtonPressed(_ sender: Any) {
    
    
    }
    
    
    // Initializing all items on register page
    @IBOutlet weak var usernameRegister: UITextField!
    @IBOutlet weak var fNameRegister: UITextField!
    @IBOutlet weak var lNameRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var confirmPasswordRegister: UITextField!
    
    
    // function that will register a user if the button is pressed
    @IBAction func registerButtonPressed(_ sender: Any) {

        // error checking if user filled out username, email, and password
        // shows an alert if any of these three are not filled out
        if (usernameRegister.text == nil || (usernameRegister.text?.isEmpty)!) {
            //showAlertError("Username required", message: "")
            let alertController = UIAlertController(title: "USERNAME NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Username needed!")
            return
        }
        if (fNameRegister.text == nil || (fNameRegister.text?.isEmpty)!) {
            //showAlertError("Username required", message: "")
            let alertController = UIAlertController(title: "FIRSTNAME NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("First Name needed!")
            return
        }
        
        if (lNameRegister.text == nil || (lNameRegister.text?.isEmpty)!) {
            //showAlertError("Username required", message: "")
            let alertController = UIAlertController(title: "LASTNAME NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Last Name needed!")
            return
        }
        
        if (emailRegister.text == nil || (emailRegister.text?.isEmpty)!) {
            //showAlertError("Email Address required", message: "")
            let alertController = UIAlertController(title: "EMAIL NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Email needed!")
            return
        }
        
        if (passwordRegister.text == nil || (passwordRegister.text?.isEmpty)!) {
            //showAlertError("Password required", message: "")
            let alertController = UIAlertController(title: "PASSWORD NEEDED!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Password needed!")
            return
        }
        
        if (confirmPasswordRegister.text == nil || (confirmPasswordRegister.text?.isEmpty)!) {
            //showAlertError("Password required", message: "")
            let alertController = UIAlertController(title: "CONFIRM YOUR PASSWORD!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Confirm your password!")
            return
        }
        
        if passwordRegister.text != confirmPasswordRegister.text{
            let alertController = UIAlertController(title: "PASSWORDS DO NOT MATCH!", message: nil, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
            self.present(alertController, animated: true, completion: nil)
            print("Enter matching passwords!")
            return
        }
        // creating parameters for the post request
        let params = ["username": usernameRegister.text!,
                      "firstname" : fNameRegister.text!,
                      "lastname" : lNameRegister.text!,
                      "email": emailRegister.text!,
                      "password": passwordRegister.text!,
                      "confirmpass":confirmPasswordRegister.text!
            ] as [String : Any]
        
        // making a post request
        // basically take in the parameters (username, email and password) we specify and
        // see if will create a new user if the username and email aren't already in use
        AF.request(URL_USER_REGISTER, method: .post, parameters: params, encoding: URLEncoding.default).responseString { (response) in
            
            // printing response for testing purposes
            print(response);
           
            // error checking if user already exists
            // if so, show an alert stating so
            // otherwise tell the user the registration was succesful
            if ((response.value?.contains("true"))!) {
                
                var errmsg = response.description
                errmsg = String(errmsg.dropFirst(43))
                errmsg = String(errmsg.dropLast(2))
               
                let alertController = UIAlertController(title: "Error!", message: errmsg, preferredStyle: .alert);
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "REGISTRATION SUCCESSFUL!", message: nil, preferredStyle: .alert);
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // Function that allows for Touch ID/Face ID login
    @IBAction func touchIDLoginAction() {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
            } else {
                self?.performSegue(withIdentifier: "homePage", sender: self)
            }
        }
    }
    
    // Segue back to the login screen
    @IBAction func returnToLoginButtonPressed(_ sender: Any) {
    }
    
    //Move our view back out of the keyboard view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // This will move our display up so we can edit the textfield easier
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
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

