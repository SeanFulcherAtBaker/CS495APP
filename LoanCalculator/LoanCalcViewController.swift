//
//  ViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 11/26/16.
//  Last Update on 12/10/2016
//  Copyright © 2016 Sean Fulcher. All rights reserved.
//

import UIKit

class LoanCalcViewController: UIViewController {

    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var termYearOrMonths: UISwitch!
    @IBOutlet weak var loanTermLength: UITextField!
    @IBOutlet weak var loanIntRate: UITextField!
    @IBOutlet weak var calculateLoan: UIButton!
    @IBOutlet weak var resetScreen: UIButton!
    @IBOutlet weak var loanTermLable: UILabel!
    @IBAction func resetScreenButtonClick(sender: AnyObject) {
        loanAmount.text = ""
        loanTermLength.text = ""
        loanIntRate.text = ""
        termYearOrMonths.on = true
    }
    @IBAction func calculateButtonClick(sender: AnyObject) {
       buildResults()
    }
    
    @IBAction func loanTermSwitch(sender: AnyObject) {
        if termYearOrMonths.on
        {
            loanTermLable.text = "Number of Years"
        }
        else
        {
            loanTermLable.text = "Number of Months"
        }
    }
    var loanDetailData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func buildResults(){
        let loanAmt = Double(loanAmount.text!)
        let loanR = Double(loanIntRate.text!)
        let loanT = Double(loanTermLength.text!)
        if(loanAmt>0 && loanR>0 && loanT>0){
        var n: Double?
        
        if !termYearOrMonths.on
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
        let currencyFormater = NSNumberFormatter()
        currencyFormater.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormater.locale = NSLocale(localeIdentifier: "en_US")
        
        let loan = currencyFormater.stringFromNumber(loanAmt!)
        let rate =  NSString(format: "%.\(2)f%%",loanR!) as! String
        let payment = currencyFormater.stringFromNumber(lPayment)
        let interest = currencyFormater.stringFromNumber(lIC)
        let loanCost = currencyFormater.stringFromNumber(lTC)
        
        loanDetailData = "Loan Amount: " + loan! +
            "\n" + loanTermLable.text! + ": " + loanTermLength.text! +
            "\n" + "Loan Rate: " + rate +
            "\n" + "Loan Payment: " + payment! +
            "\n" + "Total Interest For Loan: " + interest! +
            "\n" + "Total Loan Cost: " + loanCost!
        }
        else
        {
            
            let alertController = UIAlertController(title: "Invalid Loand Entry", message: "Please Enter Vailid Loan Amount, Rate, and Term", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let loanDetailControl = segue.destinationViewController as! LoanDetailViewController
        loanDetailControl.loanDetailResultData = loanDetailData
    }
    
    

}

