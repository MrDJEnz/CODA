//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit
import PDFKit

class DischargeController: UIViewController {
    
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
        
        
//        let pdfView = PDFView()
//
//        pdfView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(pdfView)
//
//        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        pdfView.topAnchor.constraint(equalTo: view.viewWithTag(3)!.topAnchor).isActive = true
//        pdfView.bottomAnchor.constraint(equalTo: view.viewWithTag(4)!.bottomAnchor).isActive = true
//
//        guard let path = Bundle.main.url(forResource: "lorem-ipsum", withExtension: "pdf") else { return }
//
//        if let document = PDFDocument(url: path) {
//            pdfView.document = document
//        }

        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)
        
        // Fit content in PDFView.
        pdfView.autoScales = true
        
        // Load Sample.pdf file from app bundle.
        let fileURL = Bundle.main.url(forResource: "lorem-ipsum", withExtension: "pdf")
        pdfView.document = PDFDocument(url: fileURL!)
        
        //        let range1 = finalUsername.characters.index(finalUsername.startIndex, offsetBy: 9)..<finalUsername.endIndex
        //        finalUsername = String(finalUsername[range1])
        // Do any additional setup after loading the view.
    }
    
    //@IBAction func goHome(_ sender: Any) {
    @IBAction func goHome(_ sender: Any) {
    performSegue(withIdentifier: "dchrgHomeSegue", sender: self)
}
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! HomeController
    
    vc.userValue = self.finalUsername
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
