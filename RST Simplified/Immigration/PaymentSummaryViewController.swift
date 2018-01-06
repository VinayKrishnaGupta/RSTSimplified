//
//  PaymentSummaryViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 06/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit

class PaymentSummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func proceedButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "paymentPage", sender: self)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
