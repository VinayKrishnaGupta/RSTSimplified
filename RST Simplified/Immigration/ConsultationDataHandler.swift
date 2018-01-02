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
    var SelectedService = String()
    var SelectedLivingInName = String()
    var SelectedLivingInID = String()
  
    static let sharedInstance:ConsultationDataHandler = {
        let instance = ConsultationDataHandler ()
        return instance
    } ()
    
    override init() {
        super.init()
    }
    
    
}
