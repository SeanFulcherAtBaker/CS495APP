//
//  LoanDetailViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 11/28/16.
//  Copyright © 2016 Sean Fulcher. All rights reserved.
//Released For grading
//

import UIKit
import MessageUI

class LoanDetailViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var LoanDetailTextView: UITextView!
    @IBOutlet weak var emailButton: UIButton!
   
    @IBOutlet weak var emailTo: UITextField!
    @IBAction func emailButtonClick(sender: AnyObject) {
        if (isValidEmail(emailTo.text!)){
            if MFMailComposeViewController.canSendMail()
            {
                var mailVC = MFMailComposeViewController()
                
                mailVC.setSubject("Your Loan Information")
                mailVC.setToRecipients([emailTo.text!])
                mailVC.setMessageBody(loanDetailResultData!, isHTML: false)
                mailVC.mailComposeDelegate = self;
            
                self.presentViewController((mailVC), animated: true, completion: nil)
            
            }
            else
            {
                print("This Device isn't setup to email")
            }
        }
        else
        {
            let alertController = UIAlertController(title: "Email To Error", message: "Please Enter a Vailid Email Address", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    var loanDetailResultData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoanDetailTextView.text = ""
        LoanDetailTextView.text = loanDetailResultData
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        let alerMessage: String
        switch result.rawValue{
            
        case MFMailComposeResultSent.rawValue:
            alerMessage = "Email Sent"
            
        case MFMailComposeResultCancelled.rawValue:
            alerMessage = "Email Cancelled"
            
        case MFMailComposeResultFailed.rawValue:
            alerMessage = "Unable to Send Email"
            
        case MFMailComposeResultSaved.rawValue:
            alerMessage = "Email Saved as Draft"
            
        default:
            alerMessage = "Unknown Error";
            
        }
        let alertController = UIAlertController(title: "Email", message: alerMessage, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
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
