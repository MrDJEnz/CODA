//
//  ViewController.swift
//  ParserDemoApp
//
//  Created by Benjamin Garrigues on 27/06/2018.
//

import UIKit

class ViewController: UIViewController {

    var documentIndexer = SimpleDocumentIndexer()

    @IBOutlet weak var scrllView: UIScrollView!
    var page = 1
    let fileName = "Kurt the Cat"
    let fontName = "Arial"
    var text = ""
    
    @IBAction func nxtPge(_ sender: Any) {
        page += 1
    }
    @IBAction func prvPage(_ sender: Any) {
        page -= 1
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let documentPath = Bundle.main.path(forResource:fileName , ofType: "pdf", inDirectory: nil, forLocalization: nil)

        let parser = try! Parser(documentURL: URL(fileURLWithPath: documentPath!), delegate:self, indexer: documentIndexer)
        parser.parse()

        print( "Raw dump : \n")
        print(documentIndexer.pageIndexes[page]!.textBlocks)

        print( "\nLines : \n")
        print(documentIndexer.pageIndexes[page]!.allLinesDescription())
        showPage(pageIndex: documentIndexer.pageIndexes[page]!)
        print("GATHERED TEXT:\n")
        print(text)
    }

    func showPage(pageIndex: SimpleDocumentIndexer.PageIndex) {
        for (_, l) in pageIndex.lines {
            showLine(l)
        }
 
        for var b in pageIndex.textBlocks {
            showBlock(&b)
        }
    }
    

    func showLine(_ line: SimpleDocumentIndexer.LineTextBlock) {
        for var b in line.blocks {
            showBlock(&b)
        }
    }

    func showBlock(_  textBlock: inout TextBlock) {
        let labl = UILabel(frame: textBlock.frame.insetBy(dx: 0, dy: -textBlock.renderingState.deviceSpaceFontSize * 2))
        if let fontDescr =  UIFont(name: fontName, size: textBlock.renderingState.deviceSpaceFontSize)?.fontDescriptor.withSymbolicTraits(textBlock.attributes.fontTraits)  {
            labl.font = UIFont(descriptor: fontDescr, size: textBlock.renderingState.deviceSpaceFontSize)
        }
        
        self.scrllView.addSubview(labl)
        self.scrllView.clipsToBounds = true
        labl.backgroundColor = UIColor.clear
        labl.lineBreakMode = .byClipping
        labl.text = textBlock.chars
        text += textBlock.chars
        labl.textColor = UIColor.black
        
        //self.scrllView.autoresizesSubviews = true
        
        //view.layer.rasterizationScale = view.window.screen.scale;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: ParserDelegate {
    func parser(p: Parser, didCompleteWithError error: Error?) {
        if let error = error {
            print(error)
        }
    }
}



////
////  ViewController.swift
////  ParserDemoApp
////
////  Created by Benjamin Garrigues on 27/06/2018.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    var documentIndexer = SimpleDocumentIndexer()
//
//    let page = 1
//    let fileName = "Kurt the Cat"
//    let fontName = "BaskerVille"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        let documentPath = Bundle.main.path(forResource:fileName , ofType: "pdf", inDirectory: nil, forLocalization: nil)
//
//        let parser = try! Parser(documentURL: URL(fileURLWithPath: documentPath!), delegate:self, indexer: documentIndexer)
//        parser.parse()
//
//        print( "Raw dump : \n")
//        print(documentIndexer.pageIndexes[page]!.textBlocks)
//
//        print( "\nLines : \n")
//        print(documentIndexer.pageIndexes[page]!.allLinesDescription())
//        showPage(pageIndex: documentIndexer.pageIndexes[page]!)
//    }
//
//    func showPage(pageIndex: SimpleDocumentIndexer.PageIndex) {
//        /*for (_, l) in pageIndex.lines {
//         showLine(l)
//         }
//         */
//        for var b in pageIndex.textBlocks {
//            showBlock(&b)
//        }
//    }
//
//    func showLine(_ line: SimpleDocumentIndexer.LineTextBlock) {
//        for var b in line.blocks {
//            showBlock(&b)
//        }
//    }
//
//    func showBlock(_  textBlock: inout TextBlock) {
//        let lbl = UILabel(frame: textBlock.frame.insetBy(dx: 0, dy: -textBlock.renderingState.deviceSpaceFontSize * 2).offsetBy(dx: 0, dy: textBlock.renderingState.deviceSpaceFontSize))
//        if let fontDescr =  UIFont(name: fontName, size: textBlock.renderingState.deviceSpaceFontSize)?.fontDescriptor.withSymbolicTraits(textBlock.attributes.fontTraits)  {
//            lbl.font = UIFont(descriptor: fontDescr, size: textBlock.renderingState.deviceSpaceFontSize)
//        }
//
//        lbl.backgroundColor = UIColor.clear
//        lbl.lineBreakMode = .byClipping
//        lbl.text = textBlock.chars
//        lbl.textColor = UIColor.black
//        self.view.addSubview(lbl)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
//
//extension ViewController: ParserDelegate {
//    func parser(p: Parser, didCompleteWithError error: Error?) {
//        if let error = error {
//            print(error)
//        }
//    }
//}
