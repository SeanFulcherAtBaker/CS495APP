//
//  ViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 01/13/2017.
//  Last Update on 01/17/2017
//  Copyright © 2017 Sean Fulcher. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class LoanCalcViewController: UIViewController {

    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var termYearOrMonths: UISwitch!
    @IBOutlet weak var loanTermLength: UITextField!
    @IBOutlet weak var loanIntRate: UITextField!
    @IBOutlet weak var calculateLoan: UIButton!
    @IBOutlet weak var resetScreen: UIButton!
    @IBOutlet weak var loanTermLable: UILabel!
    @IBAction func resetScreenButtonClick(_ sender: AnyObject) {
        loanAmount.text = ""
        loanTermLength.text = ""
        loanIntRate.text = ""
        termYearOrMonths.isOn = true
    }
    @IBAction func calculateButtonClick(_ sender: AnyObject) {
       calculateResults()
    }
    
    @IBAction func loanTermSwitch(_ sender: AnyObject) {
        if termYearOrMonths.isOn
        {
            loanTermLable.text = "Number of Years"
        }
        else
        {
            loanTermLable.text = "Number of Months"
        }
    }
    var loanDetailAmt: String?
    var loanDetailTerm: String?
    var loanDetailRate: String?
    var loanDetailPayment: String?
    var loanDetailTotalIntrest: String?
    var loanDetailTotalCost: String?
    var loanDetailEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calculateResults(){
        let loanAmt = Double(loanAmount.text!)
        let loanR = Double(loanIntRate.text!)
        let loanT = Double(loanTermLength.text!)
        if(loanAmt>0 && loanR>0 && loanT>0){
        var n: Double?
        
        if !termYearOrMonths.isOn
        {
                n = loanT
        }
        else
        {
            n = (loanT! * 12)
        }
        let i = (loanR!/100)/12
        let ir = (1+i)
        let loanP = (pow(ir, n!)-1)/(i*pow(ir, n!))
        let lPayment = loanAmt!/loanP
        let lTC = n! * lPayment
        let lIC = lTC - loanAmt!
        let currencyFormater = NumberFormatter()
        currencyFormater.numberStyle = NumberFormatter.Style.currency
        currencyFormater.locale = Locale(identifier: "en_US")
        
            let loan = currencyFormater.string(from: NSNumber(value: loanAmt!))
            let rate =  NSString(format: "%.\(2)f%%" as NSString,loanR!) as String
            let payment = currencyFormater.string(from: NSNumber(value: lPayment))
            let interest = currencyFormater.string(from: NSNumber(value: lIC))
            let loanCost = currencyFormater.string(from: NSNumber(value: lTC))
        
        loanDetailEmail = "Loan Amount: " + loan! +
            "\n" + loanTermLable.text! + ": " + loanTermLength.text! +
            "\n" + "Loan Rate: " + rate +
            "\n" + "Loan Payment: " + payment! +
            "\n" + "Total Interest For Loan: " + interest! +
            "\n" + "Total Loan Cost: " + loanCost!
            
            loanDetailAmt = "Loan Amount: " + loan!
            loanDetailTerm = loanTermLable.text! + ": " + loanTermLength.text!
            loanDetailRate = "Loan Rate: " + rate
            loanDetailPayment = "Loan Payment: " + payment!
            loanDetailTotalIntrest = "Total Interest For Loan: " + interest!
            loanDetailTotalCost = "Total Loan Cost: " + loanCost!
            
        }
        else
        {
            
            let alertController = UIAlertController(title: "Invalid Loand Entry", message: "Please Enter Vailid Loan Amount, Rate, and Term", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let loanDetailControl = segue.destination as! LoanDetailViewController
        loanDetailControl.loanDetailAmt = loanDetailAmt
        loanDetailControl.loanDetailTerm = loanDetailTerm
        loanDetailControl.loanDetailRate = loanDetailRate
        loanDetailControl.loanDetailPayment = loanDetailPayment
        loanDetailControl.loanDetailTotalIntrest = loanDetailTotalIntrest
        loanDetailControl.loanDetailTotalCost = loanDetailTotalCost
        loanDetailControl.loanDetailResultData = loanDetailEmail

    }
    
    

}

