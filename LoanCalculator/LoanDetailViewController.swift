//
//  LoanDetailViewController.swift
//  LoanCalculator
//
//  Created by Sean Fulcher on 11/28/16.
//  Copyright © 2016 Sean Fulcher. All rights reserved.
//

import UIKit

class LoanDetailViewController: UIViewController {

    @IBOutlet weak var LoanDetailTextView: UITextView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBAction func emailButtonClick(sender: AnyObject) {
    }
    @IBAction func returnButtonClick(sender: AnyObject) {
    }
    var loanDetailResultData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoanDetailTextView.text = loanDetailResultData
        // Do any additional setup after loading the view.
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
