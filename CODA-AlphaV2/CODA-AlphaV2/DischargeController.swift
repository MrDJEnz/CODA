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
    
    var documentIndexer = SimpleDocumentIndexer()
    let fileName = "discharge"
    let fontName = "Arial"
    var pdfText = ""
    var textfield = "" //the entire pdf
    var WatchForText = "" //Symptoms to Call Your Doctor About:" to "Appointments:"
    var AppointmentText = "" //text from "Appointments:" to "What can I expect from having a ureteral stent"
    var ProblemText = "" //text from "What can I expect from having a ureteral stent?" to "How long will the stent remain in my body?"
    var MedicationText = "" //text from "PAIN CONTROL:" to "BATHING:"
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HomeController
        
        vc.userValue = self.finalUsername
    }
    
    
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
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let documentPath = Bundle.main.path(forResource: fileName , ofType: "pdf", inDirectory: nil, forLocalization: nil)
        
        let parser = try! Parser(documentURL: URL(fileURLWithPath: documentPath!), delegate:self, indexer: documentIndexer)
        parser.parse()
        guard let path2 = Bundle.main.url(forResource: fileName, withExtension: "pdf")
            else {return}
        if let pdfDocument = PDFDocument(url: path2) {
            //documentContent should contain the pdf as attributed text (with font size/color/etc)
            let pageCount = pdfDocument.pageCount
            for i in 1 ..< pageCount {
                //print(documentIndexer.pageIndexes[i]!.allLinesDescription())
                showPage(pageIndex: documentIndexer.pageIndexes[i]!)
            }
            print("PAGES COUNT: \(pageCount)")
        }
        print("GATHERED TEXT:\n")
        print(textfield)
        
        
       
        
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
    }
    
    //@IBAction func goHome(_ sender: Any) {
    @IBAction func goHome(_ sender: Any) {
    performSegue(withIdentifier: "dchrgHomeSegue", sender: self)
}
    
    func showPage(pageIndex: SimpleDocumentIndexer.PageIndex) {
//        for (_, l) in pageIndex.lines {
//            showLine(l)
//        }
        
        for var b in pageIndex.textBlocks {
            showBlock(&b)
        }
    }
    
    
//    func showLine(_ line: SimpleDocumentIndexer.LineTextBlock) {
//        for var b in line.blocks {
//            showBlock(&b)
//        }
//    }
    
    func showBlock(_  textBlock: inout TextBlock) {
        let labl = UILabel(frame: textBlock.frame.insetBy(dx: 0, dy: -textBlock.renderingState.deviceSpaceFontSize * 2))
//        if let fontDescr =  UIFont(name: fontName, size: textBlock.renderingState.deviceSpaceFontSize)?.fontDescriptor.withSymbolicTraits(textBlock.attributes.fontTraits)  {
//            labl.font = UIFont(descriptor: fontDescr, size: textBlock.renderingState.deviceSpaceFontSize)
//        }
//
//        self.pdfView.addSubview(labl)
//        self.pdfView.clipsToBounds = true
//        labl.backgroundColor = UIColor.clear
//        labl.lineBreakMode = .byClipping
        //textfield += textBlock.chars
        labl.text = textBlock.chars
        //print(labl.text as Any)
        self.pdfText = self.pdfText + labl.text!
        print(pdfText as Any)
//        labl.textColor = UIColor.black
        
        //self.pdfView.autoresizesSubviews = true
        
        //view.layer.rasterizationScale = view.window.screen.scale;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DischargeController: ParserDelegate {
    func parser(p: Parser, didCompleteWithError error: Error?) {
        if let error = error {
            print(error)
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
