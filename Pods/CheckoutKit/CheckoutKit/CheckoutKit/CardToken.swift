//
//  CardToken.swift
//  CheckoutKit
//
//  Created by Manon Henrioux on 17/08/2015.
//  Copyright (c) 2015 Checkout.com. All rights reserved.
//

import Foundation

/** Class instantiated when the createCardToken method of CheckoutKit is called, it contains all the information returned by  Checkout */

open class CardToken: Serializable {
    
    open var expMonth: String!
    open var expYear: String!
    open var billDetails: CustomerDetails?
    open var last4: String!
    open var paymentMethod: String!
    open var name: String!
    open var id: String!
    
    open var logging: Bool = false
    
    /**
    
    Default constructor for a CardToken
    
    @param expMonth String containing the expiring month of the card
    
    @param expYear String containing the expiring year of the card
    
    @param billDetails Object containing the billing details of the customer
    
    @param last4 String containing the last 4 digits of the card's number
    
    @param paymentMethod String containing the payment method corresponding to the card
    
    @param name String corresponding the the card's owner name
    
    @param cardToken String containing the card token
    
    */
    
    public init(expMonth: String, expYear: String, billDetails: CustomerDetails, last4: String, paymentMethod: String, name: String, cardToken: String) {
        self.expYear = expYear
        self.expMonth = expMonth
        self.billDetails = billDetails
        self.last4 = last4
        self.paymentMethod = paymentMethod
        self.name = name
        self.id = cardToken
    }
    
    /**
    
    Convenience constructor
    
    @param data Dictionary [String: AnyObject] containing a JSON representation of a CardToken instance
    
    */
    
    public required init?(data: [String: AnyObject]) {
        if let year = data["expiryYear"] as? String,
            let month = data["expiryMonth"] as? String,
            let id = data["id"] as? String,
            let last4 = data["last4"] as? String,
            let paymentMethod = data["paymentMethod"] as? String {
                self.expMonth = month
                self.expYear = year
                
                self.id = id
                self.last4 = last4
                self.paymentMethod = paymentMethod
                if let name = data["name"] as? String {
                    self.name = name
                }
                if let billDetails = data["billingDetails"] as? [String: AnyObject] {
                    self.billDetails = CustomerDetails(data: billDetails)
                }
        } else {
            return nil
        }

    }
}
