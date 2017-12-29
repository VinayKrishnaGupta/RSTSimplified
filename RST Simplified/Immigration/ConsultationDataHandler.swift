//
//  ConsultationDataHandler.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 29/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class ConsultationDataHandler: NSObject {
    
    var ConsultantList = Array<Any>()
    
  
    static let sharedInstance:ConsultationDataHandler = {
        let instance = ConsultationDataHandler ()
        return instance
    } ()
    
    override init() {
        super.init()
    }
    
    
}
