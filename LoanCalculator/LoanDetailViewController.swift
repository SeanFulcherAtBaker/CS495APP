//
//  LoanDetailViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 11/28/16.
//  Copyright © 2016 Sean Fulcher. All rights reserved.
//

import UIKit
import MessageUI

class LoanDetailViewController: UIViewController, MFMailComposeViewControllerDelegate{

    @IBOutlet weak var LoanDetailTextView: UITextView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBAction func emailButtonClick(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail()
        {
            var mailVC = MFMailComposeViewController()
            
            mailVC.setSubject("Your Loan Information")
            mailVC.setToRecipients(["seanfulcher@yahoo.com"])
            mailVC.setMessageBody(loanDetailResultData!, isHTML: false)
            mailVC.mailComposeDelegate = self;
            
            self.presentViewController((mailVC), animated: true, completion: nil)
            
        }
        else
        {
            print("This Device isn't setup to email")
        }
    }
    @IBAction func returnButtonClick(sender: AnyObject) {
        
    }
    var loanDetailResultData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoanDetailTextView.text = loanDetailResultData
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
