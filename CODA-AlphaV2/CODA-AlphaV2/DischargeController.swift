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
    
    let fileName = "discharge"
    let fontName = "Arial"
    var pdfText = "" // the entire pdf
    var WatchForText = "" //Symptoms to Call Your Doctor About:" to "Appointments:"
    var AppointmentText = "" //text from "Appointments:" to "What can I expect from having a ureteral stent"
    var ProblemText = "" //text from "What can I expect from having a ureteral stent?" to "How long will the stent remain in my body?"
    var MedicationText = "" //text from "PAIN CONTROL:" to "BATHING:"
    
    
    
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
        
        // Online PDF
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
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "pdf")
            else {
                errorMessage.text = "Error retreiving file"
            
                let alertController = UIAlertController(title: "ERROR!", message: "Cannot connect to internet or invalid pdf file. Please contact your System Administrator for any questions: CODA.Dev.UVM@gmail.com", preferredStyle: .alert);
            
                alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
                self.present(alertController, animated: true, completion: nil)
                return
                
        }
        
        if let pdfDocument = PDFDocument(url: path) {
            //documentContent should contain the pdf as attributed text (with font size/color/etc)
            let pageCount = pdfDocument.pageCount
            let documentContent = NSMutableAttributedString()
            for i in 0 ..< pageCount {
                guard let page = pdfDocument.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            self.pdfText = documentContent.string

            // Auto resize for the different devices.
            pdfView.autoresizesSubviews = true
            pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
            pdfView.displayDirection = .vertical
            // Set the orientation and the document it self
            pdfView.autoScales = true
            pdfView.displayMode = .singlePageContinuous
            pdfView.displaysPageBreaks = true
            pdfView.document = pdfDocument
            // Set the scaling of the pdf view
            pdfView.maxScaleFactor = 4.0
            pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
            
        }
        print("GATHERED TEXT:\n")
        print(self.pdfText)
        
        // Change the text for the following
//        WatchForText
        self.WatchForText = searchPdfText(from: "Symptoms to Call Your Doctor About:", to: "Appointments:")
        
//        AppointmentText
        self.AppointmentText = searchPdfText(from: "Appointments:", to: "What can I expect from having a ureteral stent?")
        
//        ProblemText
        self.ProblemText = searchPdfText(from: "What can I expect from having a ureteral stent?", to: "How long will the stent remain in my body?")
        
//        MedicationText
        self.MedicationText = searchPdfText(from: "PAIN CONTROL:", to: "BATHING:")
        
        print("\n\nwatchFor Section: \(self.WatchForText), Appointment Section: \(self.AppointmentText), Problems list: \(self.ProblemText), Medication List: \(self.MedicationText)")
    }
    
    func searchPdfText(from queryOne: String, to queryTwo: String) -> String {
        //these ifs are just error checking
        if self.pdfText.contains(queryOne) {
            if self.pdfText.contains(queryTwo) {
                //get locations of the two queries as sub-ranges
                let range1 = self.pdfText.range(of:queryOne)
                let range2 = self.pdfText.range(of:queryTwo)
                
                //convert the sub-ranges to just be their lower bounds
                let startPos = range1!.lowerBound.samePosition(in: self.pdfText)
                let endPos = range2!.lowerBound.samePosition(in: self.pdfText)
                
                //make a super range out of the two sub-ranges
                let range = startPos!..<endPos!
                
                //make a substring out of the pdf using the range
                let subStr = self.pdfText[range]
                
                //convert substring to string
                var rtnStr = ""
                rtnStr.append(String(subStr))
                
                return rtnStr
            } else {
                return "ERROR: Query 2 not found in pdf"
            }
        } else {
            return "ERROR: Query 1 not found in pdf"
        }
    }

    //@IBAction func goHome(_ sender: Any) {
    @IBAction func goHome(_ sender: Any) {
    
}
    
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "dchHomeSegue", sender: self)
    }
    
    @IBAction func goMedButton(_ sender: Any) {
        performSegue(withIdentifier: "dchMedSegue", sender: self)
    }
    @IBAction func goProblemButton(_ sender: Any) {
        performSegue(withIdentifier: "dchProblemSegue", sender: self)
    }
    @IBAction func goAppointmentButton(_ sender: Any) {
        performSegue(withIdentifier: "dchAppointmentSegue", sender: self)
    }
    @IBAction func goWatchButton(_ sender: Any) {
        performSegue(withIdentifier: "dchWatchSegue", sender: self)
        
    }
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "dchCallSegue", sender: self)
    }
    
    func populateFields(){
        guard let path = Bundle.main.url(forResource: fileName, withExtension: "pdf")
            else {
                errorMessage.text = "Error retreiving file"
                
                let alertController = UIAlertController(title: "ERROR!", message: "Cannot connect to internet or invalid pdf file. Please contact your System Administrator for any questions: CODA.Dev.UVM@gmail.com", preferredStyle: .alert);
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil));
                self.present(alertController, animated: true, completion: nil)
                return
                
        }
        if let pdfDocument = PDFDocument(url: path) {
            //documentContent should contain the pdf as attributed text (with font size/color/etc)
            let pageCount = pdfDocument.pageCount
            let documentContent = NSMutableAttributedString()
            for i in 0 ..< pageCount {
                guard let page = pdfDocument.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            self.pdfText = documentContent.string
            
            // Change the text for the following
            //        WatchForText
            self.WatchForText = searchPdfText(from: "Symptoms to Call Your Doctor About:", to: "Appointments:")
            
            //        AppointmentText
            self.AppointmentText = searchPdfText(from: "Appointments:", to: "What can I expect from having a ureteral stent?")
            
            //        ProblemText
            self.ProblemText = searchPdfText(from: "What can I expect from having a ureteral stent?", to: "How long will the stent remain in my body?")
            
            //        MedicationText
            self.MedicationText = searchPdfText(from: "PAIN CONTROL:", to: "BATHING:")
            
        let userDefault = UserDefaults.standard
        userDefault.set(self.MedicationText, forKey:"savingPDFString")
        userDefault.set(self.ProblemText, forKey: "savingPDFStringProblem")
        userDefault.set(self.AppointmentText, forKey: "savingPDFStringAppointment")
        userDefault.set(self.WatchForText, forKey: "savingPDFStringWatch")
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dchHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
            
            
        } else if segue.identifier == "dchProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
            vc.pdfGatheredProblem = self.ProblemText
           
        }
        else if segue.identifier == "dchAppointmentSegue" {
            let vc = segue.destination as! AppointmentController
            vc.finalUsername = "Welcome: " + self.finalUsername
            vc.pdfGatheredAppointment = self.AppointmentText
        }
        else if segue.identifier == "dchWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
            vc.pdfGatheredWatch = self.WatchForText
            
        }
        else if segue.identifier == "dchCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
           
        }
        else if segue.identifier == "dchMedSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = "Welcome: " + self.finalUsername
            vc.pdfGathered = self.MedicationText
            
        }
        //        let vc = segue.destination as! HomeController
        //
        //        vc.userValue = self.finalUsername
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


