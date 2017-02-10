//
//  ViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 01/13/2017.
//  Last Update on 02/09/2017
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
   //Resets all screen textboxs
    @IBAction func resetScreenButtonClick(_ sender: AnyObject) {
        loanAmount.text = ""
        loanTermLength.text = ""
        loanIntRate.text = ""
        termYearOrMonths.isOn = true
    }
    //Calculate Button Click
    @IBAction func calculateButtonClick(_ sender: AnyObject) {
       let loanAmt = Double(loanAmount.text!)
        //Validates Loan Amount
        if loanAmt!>=1000
        {
            //Validates Loan Term
            if verifyLoanTerm()
            {
                //Validate Loan Rate
                if verifyLoanRate()
                {
                    calculateResults()
                }
            }
            
        }
        else
        {
            //Alerts user to invalid loan amount entered
            let alertController = UIAlertController(title: "Invalid Loan Amount Entry", message: "Please Enter Minium Loan Amount of 1000 ", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    //switches between years and months for loan term
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
    var loanDetailAmt: String? //holds loan amount
    var loanDetailTerm: String? //holds loan term
    var loanDetailRate: String? //holds loan rate
    var loanDetailPayment: String? //holds loan payment
    var loanDetailTotalIntrest: String?//holds total interest for loan
    var loanDetailTotalCost: String?//holds total loan cost
    var loanDetailEmail: String?//holds formated email body
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Validates Loan Term to be <=10 years
    func  verifyLoanTerm() ->Bool{
        var isValid=false
        let loanTerm = Double(loanTermLength.text!)
        if (termYearOrMonths.isOn && loanTerm!<=10)
        {
            isValid=true
            
        }
        else if (!termYearOrMonths.isOn && loanTerm!<=120)
        {
            isValid=true
            
        }
        
        if !isValid
        {
            //alerts user to invalid loan term
            let alertController = UIAlertController(title: "Invalid Loan Term Entry", message: "Please Enter Vailid Loan Term that is Less than or Equal to 10 Years or 120 months", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)

        }
        
        return isValid
    }
    //verifys that rate in between .25 and 100 percent
    func  verifyLoanRate() ->Bool{
        var isValid=false
        let loanRate = Double(loanIntRate.text!)
        if (loanRate!>=0.25 && loanRate!<=100)
        {
            isValid=true
            
        }
        
        
        if !isValid
        {
            //alerts user that loan rate is invlaid
            let alertController = UIAlertController(title: "Invalid Loan Rate Entry", message: "Please Enter Vailid Loan Rate from .25 to 100", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
        return isValid
    }
    //Caclulates Loan Payment
    func calculateResults(){
        let loanAmt = Double(loanAmount.text!)
        let loanR = Double(loanIntRate.text!)
        let loanT = Double(loanTermLength.text!)
        
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
        //formats email body
        loanDetailEmail = "Loan Amount: " + loan! +
            "\n" + loanTermLable.text! + ": " + loanTermLength.text! +
            "\n" + "Loan Rate: " + rate +
            "\n" + "Loan Payment: " + payment! +
            "\n" + "Total Interest For Loan: " + interest! +
            "\n" + "Total Loan Cost: " + loanCost!
         //loads varables to be passed to laon detail view
            loanDetailAmt = "Loan Amount: " + loan!
            loanDetailTerm = loanTermLable.text! + ": " + loanTermLength.text!
            loanDetailRate = "Loan Rate: " + rate
            loanDetailPayment = "Loan Payment: " + payment!
            loanDetailTotalIntrest = "Total Interest For Loan: " + interest!
            loanDetailTotalCost = "Total Loan Cost: " + loanCost!
            
        
        
    }
    //Closes out screen keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    //Passes varables to Loan Detail View
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

