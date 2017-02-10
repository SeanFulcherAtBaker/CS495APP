//
//  LoanDetailViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 01/13/2017.
//  Last Update on 02/09/2017
//  Copyright © 2017 Sean Fulcher. All rights reserved.


import UIKit
import MessageUI

class LoanDetailViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var LoanDetailTextView: UITextView!
    @IBOutlet weak var emailButton: UIButton!
   
    @IBOutlet weak var loanTotalCostLabel: UILabel!
    @IBOutlet weak var totlIntrestLabel: UILabel!
    @IBOutlet weak var loanPmtLabel: UILabel!
    @IBOutlet weak var loanRateLabel: UILabel!
    @IBOutlet weak var loanTermLabel: UILabel!
    @IBOutlet weak var loanAmtLabel: UILabel!
    @IBOutlet weak var emailTo: UITextField!
    //handels emailing of loan detail
    @IBAction func emailButtonClick(_ sender: AnyObject) {
        if (isValidEmail(emailTo.text!)){
            if MFMailComposeViewController.canSendMail()
            {
                let mailVC = MFMailComposeViewController()
                
                mailVC.setSubject("Your Loan Information")
                mailVC.setToRecipients([emailTo.text!])
                mailVC.setMessageBody(loanDetailResultData!, isHTML: false)
                mailVC.mailComposeDelegate = self;
            
                self.present((mailVC), animated: true, completion: nil)
            
            }
            /*
             else
            {
                //used for testing
                print("This Device isn't setup to email")
            }
             */
        }
        else
        {
            //lets user know there is an issue with email
            let alertController = UIAlertController(title: "Email To Error", message: "Please Enter a Vailid Email Address", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    //varables that hold data passed from Loan Calculator View
    var loanDetailResultData: String?
    var loanDetailAmt: String?
    var loanDetailTerm: String?
    var loanDetailRate: String?
    var loanDetailPayment: String?
    var loanDetailTotalIntrest: String?
    var loanDetailTotalCost: String?
    //Loands varables passed from Loan Calcultor View
    override func viewDidLoad() {
        super.viewDidLoad()
        LoanDetailTextView.text = ""
        LoanDetailTextView.text = loanDetailResultData
        loanAmtLabel.text = ""
        loanAmtLabel.text = loanDetailAmt
        loanTermLabel.text = ""
        loanTermLabel.text = loanDetailTerm
        loanRateLabel.text = ""
        loanRateLabel.text = loanDetailRate
        loanPmtLabel.text = ""
        loanPmtLabel.text = loanDetailPayment
        totlIntrestLabel.text = ""
        totlIntrestLabel.text = loanDetailTotalIntrest
        loanTotalCostLabel.text = ""
        loanTotalCostLabel.text = loanDetailTotalCost
        // Do any additional setup after loading the view.
    }
    //clears screen keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    //email controler used to send email also notifys user if there is an email problem
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        let alerMessage: String
        switch result.rawValue{
            
        case MFMailComposeResult.sent.rawValue:
            alerMessage = "Email Sent"
            
        case MFMailComposeResult.cancelled.rawValue:
            alerMessage = "Email Cancelled"
            
        case MFMailComposeResult.failed.rawValue:
            alerMessage = "Unable to Send Email"
            
        case MFMailComposeResult.saved.rawValue:
            alerMessage = "Email Saved as Draft"
            
        default:
            alerMessage = "Unknown Error";
            
        }
        //lets user know if email was sent or if there was an issue
        let alertController = UIAlertController(title: "Email", message: alerMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //validates email addresss
    func isValidEmail(_ testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
