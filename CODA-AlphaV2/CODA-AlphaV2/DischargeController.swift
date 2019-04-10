//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit
import PDFKit
import QuartzCore

class DischargeController: UIViewController {
    
    //@IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet var pdfView: PDFView!
    @IBOutlet weak var errorMessage: UILabel!
    

    
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
        
        
        //let pdfView = PDFView()

//        pdfView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(pdfView)
//
//        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        pdfView.topAnchor.constraint(equalTo: view.viewWithTag(3)!.topAnchor).isActive = true
//        pdfView.bottomAnchor.constraint(equalTo: view.viewWithTag(4)!.bottomAnchor).isActive = true
//
//        guard let path = Bundle.main.url(forResource: "discharge", withExtension: "pdf") else { return }
//
//        if let document = PDFDocument(url: path) {
//            pdfView.document = document
//        }
//
//        let website = "http://www.sanface.com/pdf/test.pdf"
//        let reqURL =  NSURL(string: website)
//
//        if let pdfDocument = PDFDocument(url: reqURL! as URL) {
////            pdfView.displayMode = .singlePageContinuous
////            pdfView.autoScales = true
////            pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
////            pdfView.displayDirection = .vertical
////            //pdfView.document = PDFDocument(url: path)
////            pdfView.document = pdfDocument
//
//            //documentContent should contain the pdf as attributed text (with font size/color/etc)
//            let pageCount = pdfDocument.pageCount
//            let documentContent = NSMutableAttributedString()
//
//            for i in 1 ..< pageCount {
//                guard let page = pdfDocument.page(at: i) else { continue }
//                guard let pageContent = page.attributedString else { continue }
//                documentContent.append(pageContent)
//            }
//
//
//        } else {
//            errorMessage.text = "Error retreiving file"
//
//            let alertController = UIAlertController(title: "ERROR!", message: "Cannot connect to internet or invalid pdf file. Please contact your System Administrator for any questions: CODA.Dev.UVM@gmail.com", preferredStyle: .alert);
//
//            alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
//            self.present(alertController, animated: true, completion: nil)
//        }

        // FOR LOCAL PDF
        guard let path = Bundle.main.url(forResource: "discharge", withExtension: "pdf")
            else {
                errorMessage.text = "Error retreiving file"
            
                let alertController = UIAlertController(title: "ERROR!", message: "Cannot connect to internet or invalid pdf file. Please contact your System Administrator for any questions: CODA.Dev.UVM@gmail.com", preferredStyle: .alert);
            
                alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
                self.present(alertController, animated: true, completion: nil)
                return
                
        }
        
        if let pdfDocument = PDFDocument(url: path) {
                        pdfView.displayMode = .singlePageContinuous
                        pdfView.autoScales = true
                        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
                        pdfView.displayDirection = .vertical
                        pdfView.document = pdfDocument
            
                        //documentContent should contain the pdf as attributed text (with font size/color/etc)
                        let pageCount = pdfDocument.pageCount
                        let documentContent = NSMutableAttributedString()
            
                        for i in 1 ..< pageCount {
                            guard let page = pdfDocument.page(at: i) else { continue }
                            guard let pageContent = page.attributedString else { continue }
                            documentContent.append(pageContent)
                        }
            
            
                    }
        
        let pdf = PDFDocument(url: URL(fileURLWithPath: "discharge.pdf"))
        
        guard let contents = pdf?.string else {
            print("could not get string from pdf: \(String(describing: pdf))")
            return
        }
        
        let footNote = contents.components(separatedBy: "FOOT NOTE: ")[1] // get all the text after the first foot note
        
        print(footNote.components(separatedBy: "\n")[0]) // print the first line of that text
        
        // Output: "The operating system being written in C resulted in a more portable software."
            
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
