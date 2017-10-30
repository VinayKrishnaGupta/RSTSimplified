//
//  ChooseVisaTypeViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DropDown

class ChooseVisaTypeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var VisaRequiredForField: UITextField!
    
    @IBOutlet weak var CitizenOfField: UITextField!
    
    @IBOutlet weak var LivingInField: UITextField!
    
    @IBOutlet weak var StateField: UITextField!
    let VisaRequiredDropdown = DropDown()
    
    let CitizenDropdown = DropDown()
    let LivingInDropdown = DropDown()
    let StateDropdown = DropDown()
    let listofsampledata = ["A","B","C","D"]
    override func viewDidLoad() {
        super.viewDidLoad()
        VisaRequiredForField.delegate = self
        CitizenOfField.delegate = self
        LivingInField.delegate = self
        StateField.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func SetupDropDowns() {
        VisaRequiredDropdown.anchorView = VisaRequiredForField
        VisaRequiredDropdown.dataSource = listofsampledata
        VisaRequiredDropdown.direction = .any
       
        
        CitizenDropdown.anchorView = CitizenDropdown
        CitizenDropdown.dataSource = listofsampledata
        CitizenDropdown.direction = .any
        
        LivingInDropdown.anchorView = LivingInField
        LivingInDropdown.dataSource = listofsampledata
        LivingInDropdown.direction = .any
        
        VisaRequiredDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.VisaRequiredForField.text = "  " + item
            self.VisaRequiredDropdown.hide()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == VisaRequiredForField {
            VisaRequiredDropdown.show()
            return false
        }
        else {
            return true
        }
        
        
        
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == VisaRequiredForField {
            VisaRequiredDropdown.hide()
            return false
        }
        else {
            return true
        }
        
        
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
