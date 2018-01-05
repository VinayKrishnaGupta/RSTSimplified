//
//  paymentPageViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 05/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import CheckoutKit

class paymentPageViewController: UIViewController {
    
    let publicKey: String = "pk_0d595113-1ee5-4397-a685-04a1452606a2"
    let testingKey: String = "pk_test_73e56b01-8726-4176-9159-db71454ff4af"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.GenerateCardToken()
        // Do any additional setup after loading the view.
    }
    
    func GenerateCardToken() {
        var ck: CheckoutKit? = nil
        do {
            try ck = CheckoutKit.getInstance(testingKey)
        } catch _ as NSError {
            print("invalid Key")
            /* Happens when the public key is not valid, raised during the instanciation of the CheckoutKit object */
            /* Type of the error in the enum CheckoutError. Different types are NoPK (if getInstance is called with no parameters and no public key has been provided before) and InvalidPK (if the public key is invalid) */
        }
        
        
        /* Take the card information where ever you want (form, fields in the application page...) */
        var card: Card? = nil
        do {
            try card = Card(name: "Vinay Krishna Gupta", number: "4242424242424242", expYear: "2018", expMonth: "06", cvv: "101", billingDetails: nil)
        } catch let err as CardError {
            print("Incorrect card details")
            print(err)
            /* Happens when the card informations entered by the user are not correct */
            /* Type of the error in the enum CardError. Different types are InvalidCVV (if the CVV does not have the correct format), InvalidExpiryDate (if the card is expired), InvalidNumber (if the card's number is wrong). */
        } catch _ as NSError {
            /* If any other exception was thrown */
        }
        
        ck!.createCardToken(card!, completion:{ (resp: Response<CardTokenResponse>) -> Void in
            if (resp.hasError) {
                /* Print error message or handle it */
            } else {
                /* The card object */
                let ct: CardToken = resp.model!.card
                /* The field containing the card token to make a charge */
                let cardToken: String = resp.model!.cardToken
                print(cardToken)
                print(ct)
            }
        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
