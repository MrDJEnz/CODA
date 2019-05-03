//
//  AppointmentController.swift
//  CODA-AlphaV2
//
//  Created by Duncan on 3/27/19.
//  Copyright © 2019 MrDJEnz. All rights reserved.
//

import UIKit

class AppointmentController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var userLbl: UILabel!
    
    @IBOutlet weak var pdfFieldApt: UITextView!
    
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
    
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    // Creating variables for months, weekdays, and days in a month
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let DaysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var DaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    // Aligning days of the month to proper weekday
    var NumberOfEmptyBox = Int() // "Empty boxes" at start of month
    
    var NextNumberOfEmptyBox = Int() // Same as above but for next month
    
    var PreviousNumberOfEmptyBox = 0 // Same as above but for previous month
    
    var Direction = 0 // 0 if current month, 1 if future month, -1 if previous month
    
    var PositionIndex = 0 // storing above variables of empty boxes
    
    // Leap year exception
    var LeapYearCounter = 3 // set a counter for the next leap year
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            Direction = 1
            if LeapYearCounter < 5 {
                LeapYearCounter += 1
            }
            
            if LeapYearCounter == 4 {
                DaysInMonth[1] = 29
            }
            
            if LeapYearCounter == 5 {
                LeapYearCounter = 1
                DaysInMonth[1] = 28
            }
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            GetStartDateDayPosition()
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            Direction = -1
            if LeapYearCounter > 0 {
                LeapYearCounter -= 1
            }
            
            if LeapYearCounter == 0 {
                DaysInMonth[1] = 29
                LeapYearCounter = 4
            } else {
                DaysInMonth[1] = 28
            }
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    // Function to give us the number of empty boxes
    func GetStartDateDayPosition() {
        switch Direction {
        // Current month
        case 0:
            switch day {
            case 1...7:
                NumberOfEmptyBox = weekday - day
            case 8...14:
                NumberOfEmptyBox = weekday - day - 7
            case 15...21:
                NumberOfEmptyBox = weekday - day - 14
            case 22...28:
                NumberOfEmptyBox = weekday - day - 21
            case 29...31:
                NumberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            PositionIndex = NumberOfEmptyBox
        
        // Future month
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonth[month])%7
            PositionIndex = NextNumberOfEmptyBox
        
        // Past month
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonth[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(pdfGatheredAppointment, forKey: "savingPDFStringAppointment")
    }
    
    var finalUsername = ""
    var passback = ""
    var pdfGatheredAppointment = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        
        MonthLabel.text = "\(currentMonth) \(year)"
        
        pdfFieldApt.isUserInteractionEnabled = false
        
        let userDefault = UserDefaults.standard
        userDefault.value(forKey: "savingPDFStringAppointment")
        
        pdfFieldApt.text = userDefault.value(forKey: "savingPDFStringAppointment") as? String
        
        if pdfFieldApt.text == ""{
            pdfFieldApt.text = pdfGatheredAppointment
            //            print("EMPTY!")
        }else{
            pdfFieldApt.text = pdfFieldApt.text
            pdfGatheredAppointment = pdfFieldApt.text
            //            print("FILLED")
        }
        
        userLbl.text = finalUsername
        finalUsername = String(finalUsername.dropFirst(9))
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.magenta]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        //view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 1)
        
        
        //        let range1 = finalUsername.characters.index(finalUsername.startIndex, offsetBy: 9)..<finalUsername.endIndex
        //        finalUsername = String(finalUsername[range1])
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // returns number of days in month plus the number of "empty boxes" based on direction we are going
        switch Direction {
        case 0:
            return DaysInMonth[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonth[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonth[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch Direction {
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        // Hide cells smaller than 1
        if Int(cell.DateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        // Show the weekend days in different color
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        // Marks red the current date
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    @IBAction func goHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "aptHomeSegue", sender: self)
    }
    @IBAction func goMedButton(_ sender: Any) {
        performSegue(withIdentifier: "aptMedSegue", sender: self)

    }
    @IBAction func goProblemButton(_ sender: Any) {
        performSegue(withIdentifier: "aptProblemSegue", sender: self)

    }
    @IBAction func goWatchButton(_ sender: Any) {
        performSegue(withIdentifier: "aptWatchSegue", sender: self)

    }
    @IBAction func goCallButton(_ sender: Any) {
        performSegue(withIdentifier: "aptCallSegue", sender: self)

    }
    @IBAction func goDischargeButton(_ sender: Any) {
        performSegue(withIdentifier: "aptDischargeSegue", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aptHomeSegue" {
            let vc = segue.destination as! HomeController
            vc.userValue = self.finalUsername
        } else if segue.identifier == "aptProblemSegue" {
            let vc = segue.destination as! ProblemController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "aptMedSegue" {
            let vc = segue.destination as! MedicationController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "aptWatchSegue" {
            let vc = segue.destination as! WatchController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "aptCallSegue" {
            let vc = segue.destination as! CallController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        else if segue.identifier == "aptDischargeSegue" {
            let vc = segue.destination as! DischargeController
            vc.finalUsername = "Welcome: " + self.finalUsername
        }
        //        let vc = segue.destination as! HomeController
        //
        //        vc.userValue = self.finalUsername
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
