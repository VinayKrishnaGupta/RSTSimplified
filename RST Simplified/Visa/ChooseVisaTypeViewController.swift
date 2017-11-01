//
//  ChooseVisaTypeViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class ChooseVisaTypeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var VisaRequiredForField: UITextField!
    
    @IBOutlet weak var CitizenOfField: UITextField!
    
    @IBOutlet weak var LivingInField: UITextField!
    
    @IBOutlet weak var StateField: UITextField!
    let VisaRequiredDropdown = DropDown()
    
    let CitizenDropdown = DropDown()
    let LivingInDropdown = DropDown()
    let StateDropdown = DropDown()
    var CountryList = Array<Any>()
    var CountryNamesList = Array<String>()
    let listofsampledata = ["A","B","C","D"]
    override func viewDidLoad() {
        super.viewDidLoad()
        VisaRequiredForField.delegate = self
        CitizenOfField.delegate = self
        LivingInField.delegate = self
        StateField.delegate = self
        self.SetupDropDowns()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getListofCountries()
    }
    
    
    
    func SetupDropDowns() {
        VisaRequiredDropdown.anchorView = VisaRequiredForField
        VisaRequiredDropdown.dataSource = listofsampledata
        VisaRequiredDropdown.direction = .bottom
       
        
        CitizenDropdown.anchorView = CitizenOfField
        CitizenDropdown.dataSource = listofsampledata
        CitizenDropdown.direction = .bottom
        
        LivingInDropdown.anchorView = LivingInField
        LivingInDropdown.dataSource = listofsampledata
        LivingInDropdown.direction = .bottom
        
        StateDropdown.anchorView = StateField
        StateDropdown.dataSource = listofsampledata
        StateDropdown.direction = .bottom
        
        VisaRequiredDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.VisaRequiredForField.text = "  " + item
           
            
        }
        CitizenDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.CitizenOfField.text = "  " + item
            
            
        }
        LivingInDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.LivingInField.text = "  " + item
            
            
        }
        StateDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.StateField.text = "  " + item
            
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == VisaRequiredForField {
            VisaRequiredDropdown.show()
            return false
        }
        if textField == LivingInField {
            LivingInDropdown.show()
            VisaRequiredDropdown.hide()
            CitizenDropdown.hide()
            StateDropdown.hide()
            return false
        }
        if textField == CitizenOfField {
            LivingInDropdown.hide()
            VisaRequiredDropdown.hide()
            CitizenDropdown.show()
            StateDropdown.hide()
            return false
        }
        if textField == StateField {
            LivingInDropdown.hide()
            VisaRequiredDropdown.hide()
            CitizenDropdown.hide()
            StateDropdown.show()
            return false
        }
        else {
            return true
        }
        
        
        
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        LivingInDropdown.hide()
        VisaRequiredDropdown.hide()
        CitizenDropdown.hide()
        StateDropdown.hide()
        
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ProceedButton(_ sender: UIButton) {
        self.SearchButtonMethod()
    }
    func SearchButtonMethod() {
      self.performSegue(withIdentifier: "visaWebView", sender: nil)
        
        
    }
    
    func getListofCountries(){
        
        
        Alamofire.request( URL(string: "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?Type=COUNTRY&CountryId=")!, method: .get, parameters: nil, headers: nil )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.CountryList = dict.value(forKeyPath: "country") as! [Any]
                    self.CountryNamesList = dict.value(forKeyPath: "country.countryName") as! [String]
                    self.VisaRequiredDropdown.dataSource = self.CountryNamesList
                    self.CitizenDropdown.dataSource = self.CountryNamesList
                    self.LivingInDropdown.dataSource = self.CountryNamesList
                    print(dict)
                }
                else {
                    print("Error")
                }
                
        }
       
        
        
        
    }
    
    func getListofState(){
        
        Alamofire.request( URL(string: "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?Type=COUNTRY&CountryId=")!, method: .get, parameters: nil, headers: nil )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                   
                    print(dict)
                }
                else {
                    print("Error")
                }
                
        }
        
        

        
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
