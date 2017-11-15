//
//  ChooseStudentServiceViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 14/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DropDown
import SearchTextField
import Alamofire
import SVProgressHUD

class ChooseStudentServiceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var citizentextfield: SearchTextField!
    @IBOutlet weak var livingIntextfield: SearchTextField!
    @IBOutlet weak var servicerequiretextfield: UITextField!
    
    let ServicesDropDown = DropDown()
    var ServicesList = Array<String>()
    var CountryList = Array<Any>()
    var CountryNamesList = Array<String>()
  
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        servicerequiretextfield.delegate = self
//        citizentextfield.delegate = self
//        livingIntextfield.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        
        if UserDefaults.standard.value(forKeyPath: "CountryList") != nil {
            self.CountryNamesList = UserDefaults.standard.value(forKey: "CountryNamesList") as! [String]
            self.CountryList = UserDefaults.standard.value(forKeyPath: "CountryList") as! [Any]
            citizentextfield.filterStrings(self.CountryNamesList)
            livingIntextfield.filterStrings(self.CountryNamesList)
            self.SetupSearchFields()
            self.setupdropdowns()
            SVProgressHUD.dismiss()
        }
        else {
            
            Alamofire.request( URL(string: "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?Type=COUNTRY&CountryId=")!, method: .get, parameters: nil, headers: nil )
                
                
                .responseJSON { response in
                    debugPrint(response)
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 201:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    //to get JSON return value
                    if let result = response.result.value {
                        SVProgressHUD.dismiss()
                        let dict = result as! NSDictionary
                        self.CountryList = dict.value(forKeyPath: "country") as! [Any]
                        self.CountryNamesList = dict.value(forKeyPath: "country.countryName") as! [String]
                        UserDefaults.standard.set(self.CountryNamesList, forKey: "CountryNamesList")
                        UserDefaults.standard.set(self.CountryList, forKey: "CountryList")
                        UserDefaults.standard.synchronize()
                        self.citizentextfield.filterStrings(self.CountryNamesList)
                        self.livingIntextfield.filterStrings(self.CountryNamesList)
                        self.SetupSearchFields()
                        self.setupdropdowns()
                    }
                    
            }
            
        }
        
        self.ServicesList = ["UK | Short Term Study Visa","UK | Tier 4 General Study Visa", "UK | IELTS Preparation Course","UK | Student Consultancy","USA | F1-Student Visa","Canada | Student Visa","Australia | Student Visa","Australia | RPL Dimploma"]
        
        
        
      
        
        // Do any additional setup after loading the view.
    }
    
    func SetupSearchFields() {
        //citizentextfield.theme = .darkTheme()
       
        
        
        citizentextfield.startSuggestingInmediately = true
        citizentextfield.startVisible = true
        
        citizentextfield.theme.font = UIFont.systemFont(ofSize: 14)
        citizentextfield.theme.fontColor = UIColor.darkGray
        citizentextfield.theme.bgColor = UIColor.groupTableViewBackground
        citizentextfield.theme.borderColor = UIColor.white
        citizentextfield.theme.separatorColor = UIColor.darkGray
        citizentextfield.theme.cellHeight = 50
        
//        self.newView = UIView.init(frame: CGRect.init(x: 10, y: 10, width: self.view.frame.width, height: self.view.frame.height))
//        citizentextfield.willMove(toSuperview: newView)
        
        citizentextfield.itemSelectionHandler = { item, itemPosition in
        self.citizentextfield.keyboardIsShowing = false
        print(item[itemPosition].title)
        print(itemPosition)
        self.citizentextfield.text = item[itemPosition].title
        self.dismissKeyboard()
        self.citizentextfield.hideResultsList()
        }
        
        
        
        livingIntextfield.startSuggestingInmediately = true
        livingIntextfield.startVisible = true
        
        livingIntextfield.theme.font = UIFont.systemFont(ofSize: 14)
        livingIntextfield.theme.fontColor = UIColor.darkGray
        livingIntextfield.theme.bgColor = UIColor.groupTableViewBackground
        livingIntextfield.theme.borderColor = UIColor.white
        livingIntextfield.theme.separatorColor = UIColor.darkGray
        livingIntextfield.theme.cellHeight = 50
        
        
        livingIntextfield.itemSelectionHandler = { item, itemPosition in
            self.livingIntextfield.keyboardIsShowing = false
            print(item[itemPosition].title)
            print(itemPosition)
            self.livingIntextfield.text = item[itemPosition].title
            self.livingIntextfield.hideResultsList()
            self.dismissKeyboard()
        }
        
        
//        let window : UIWindow = UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        citizentextfield.willMove(toWindow: window)
//
        
        
       
        
    }
    func setupdropdowns() {
        ServicesDropDown.anchorView = servicerequiretextfield
        ServicesDropDown.dataSource = ServicesList
        ServicesDropDown.direction = .any
        
        ServicesDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.servicerequiretextfield.text = " " + item
           
            
        }
        
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == servicerequiretextfield {
            ServicesDropDown.show()
            return false
        }
        if textField == citizentextfield {
            
            return true
        }
        if textField == livingIntextfield {
            return true
        }
        else {
            return true
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == servicerequiretextfield {
            ServicesDropDown.hide()
        }
        else if textField == citizentextfield {
             citizentextfield.hideResultsList()
            self.dismissKeyboard()
        }
        else if textField == livingIntextfield {
            livingIntextfield.hideResultsList()
            self.dismissKeyboard()
        }
        
       
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchButton(_ sender: UIButton) {
        self.SearchButtonMethod()
    }
    
    func SearchButtonMethod(){
        let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
        vc.URLString = "https://uk-immigrationhub.com//leadForm/Tier-4-General-Study-Visa"
        self.navigationController?.pushViewController(vc, animated: true)
        
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
