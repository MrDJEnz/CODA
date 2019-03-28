//
//  ProblemController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class ProblemController: UIViewController {

    @IBOutlet weak var userLbl: UILabel!
    
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
    
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "prbHomeSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HomeController
        
        vc.userValue = self.finalUsername
    }
    

}
