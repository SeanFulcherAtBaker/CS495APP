//
//  ViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 11/26/16.
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func buildResults(){
        let loanAmt = Double(loanAmount.text!)
        let loanR = Double(loanIntRate.text!)
        let loanT = Double(loanTermLength.text!)
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
            "\n\n" + loanTermLable.text! + ": " + loanTermLength.text! +
            "\n\n" + "Loan Rate: " + rate +
            "\n\n" + "Loan Payment: " + payment! +
            "\n\n" + "Total Interest For Loan: " + interest! +
            "\n\n" + "Total Loan Cost: " + loanCost!
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let loanDetailControl = segue.destinationViewController as! LoanDetailViewController
        loanDetailControl.loanDetailResultData = loanDetailData
    }

}

