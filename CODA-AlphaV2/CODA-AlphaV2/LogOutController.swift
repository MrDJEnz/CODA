//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class LogOutController: UIViewController {
    
    @IBOutlet weak var userLbl: UILabel!
    //@IBOutlet weak var userLbl: UILabel!
    var finalUsername = ""
    var passback = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
        //        let range1 = finalUsername.characters.index(finalUsername.startIndex, offsetBy: 9)..<finalUsername.endIndex
        //        finalUsername = String(finalUsername[range1])
        // Do any additional setup after loading the view.
    }
    
    //@IBAction func goHome(_ sender: Any) {
    @IBAction func goHome(_ sender: Any) {
    performSegue(withIdentifier: "logOutHomeSegue", sender: self)
}
    @IBAction func logOut(_ sender: Any) {
        performSegue(withIdentifier: "logOutSegue", sender: self)
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "logOutHomeSegue" {
        let vc = segue.destination as! HomeController
         vc.userValue = self.finalUsername
    }
   
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
