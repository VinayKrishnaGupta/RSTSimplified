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

class ChooseStudentServiceViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var citizentextfield: UITextField!
    @IBOutlet weak var livingIntextfield: UITextField!
    @IBOutlet weak var servicerequiretextfield: UITextField!
    
    let ServicesDropDown = DropDown()
    var ServicesList = Array<String>()
    var CountryList = Array<Any>()
    var CountryNamesList = Array<String>()
    var selectedService = String()
    var SelectedNationalityName = String()
    var SelectedNationalityID = String()
    var SelectedLivingInName = String()
    var SelectedLivingInID = String()
    
    
    private var CitizenPicker: UIPickerView!
    private var LivingINPicker: UIPickerView!
    private var ServicesPicker: UIPickerView! //ServicesPicker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "Student Services"
      //  servicerequiretextfield.delegate = self
        self.ServicesList = ["Select One","UK | Short Term Study Visa","UK | Tier 4 General Study Visa", "UK | IELTS Preparation Course","UK | Student Consultancy","USA | F1-Student Visa","Canada | Student Visa","Australia | Student Visa","Australia | RPL Diploma"]
       // self.setupdropdowns()
//        citizentextfield.delegate = self
//        livingIntextfield.delegate = self
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
       // view.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        
        if UserDefaults.standard.value(forKeyPath: "CountryList") != nil {
            self.CountryNamesList = UserDefaults.standard.value(forKey: "CountryNamesList") as! [String]
            self.CountryList = UserDefaults.standard.value(forKeyPath: "CountryList") as! [Any]
//            citizentextfield.filterStrings(self.CountryNamesList)
//            livingIntextfield.filterStrings(self.CountryNamesList)
//            self.SetupSearchFields()
            self.SetUpPickers()
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
                         self.SetUpPickers()
//                        self.citizentextfield.filterStrings(self.CountryNamesList)
//                        self.livingIntextfield.filterStrings(self.CountryNamesList)
//                        self.SetupSearchFields()
                      
                    }
                    
            }
            
        }
        
        
        
        
        
      
        
        // Do any additional setup after loading the view.
    }
    func BackButtonmethod() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func SetUpPickers(){
        
        CitizenPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        CitizenPicker.dataSource = self
        CitizenPicker.delegate = self
        CitizenPicker.backgroundColor = UIColor.groupTableViewBackground
        citizentextfield.inputView = CitizenPicker
        
        LivingINPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        LivingINPicker.dataSource = self
        LivingINPicker.delegate = self
        LivingINPicker.backgroundColor = UIColor.groupTableViewBackground
        livingIntextfield.inputView = LivingINPicker
        
        
        ServicesPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        ServicesPicker.dataSource = self
        ServicesPicker.delegate = self
        ServicesPicker.backgroundColor = UIColor.groupTableViewBackground
        servicerequiretextfield.inputView = ServicesPicker
        ServicesPicker.sizeToFit()
        
        //PickerToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(red: 0.0, green: 122/255, blue: 1, alpha: 1)
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        
        
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ChooseVisaTypeViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ChooseVisaTypeViewController.cancelClick))
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        doneButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
        
        citizentextfield.inputAccessoryView = toolBar
        livingIntextfield.inputAccessoryView = toolBar
        servicerequiretextfield.inputAccessoryView = toolBar
      
        
        
        
    }
    
    func doneClick() {
        let indexpath = CitizenPicker.selectedRow(inComponent: 0)
        if indexpath>0 {
            citizentextfield.text = " " + CountryNamesList[indexpath]
            self.SelectedNationalityName = CountryNamesList[indexpath].replacingOccurrences(of: " ", with: "-")
            let dict : Dictionary<String,String> = CountryList[indexpath] as! Dictionary<String, String>
            self.SelectedNationalityID = dict["countryid"]! + "-" + self.SelectedNationalityName
           
            
            
            if LivingINPicker.selectedRow(inComponent: 0)>0 {
                let indexpath1 = LivingINPicker.selectedRow(inComponent: 0)
                livingIntextfield.text = " " + CountryNamesList[indexpath1]
                self.SelectedLivingInName = CountryNamesList[indexpath1].replacingOccurrences(of: " ", with: "-")
                let dict1 : Dictionary<String,String> = CountryList[indexpath] as! Dictionary<String, String>
                self.SelectedLivingInID = dict1["countryid"]! + "-" + self.SelectedLivingInName
                
                
                let indexpath2 = ServicesPicker.selectedRow(inComponent: 0)
                if indexpath2>0{
                    servicerequiretextfield.text = " " + ServicesList[indexpath2]
                    
                    self.selectedService = ServicesList[indexpath2]
                    
                }
                
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        citizentextfield.resignFirstResponder()
        livingIntextfield.resignFirstResponder()
        servicerequiretextfield.resignFirstResponder()
        
    }
    
    
    
    
    
    
    
    func cancelClick() {
        citizentextfield.resignFirstResponder()
        livingIntextfield.resignFirstResponder()
        servicerequiretextfield.resignFirstResponder()
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == CitizenPicker {
            if CountryNamesList.count > 0 {
                return CountryNamesList[row]
            }
            else {
                return nil
            }
            
        }
        else if pickerView == LivingINPicker {
            if CountryNamesList.count>0{
                return CountryNamesList[row]
            }
            else {
                return nil
            }
            
        }
        else if pickerView == ServicesPicker {
            if ServicesList.count>0 {
                return ServicesList[row]
            }
            else {
                return nil
            }
            
        }
        
        else {
            return nil
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == CitizenPicker {
            return CountryNamesList.count
        }
        else if pickerView == LivingINPicker {
            return CountryNamesList.count
        }
        else if pickerView == ServicesPicker {
            return ServicesList.count
        }
            
        else {
            return 0
        }
    }
    
/*
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
            self.SelectedNationalityName = item[itemPosition].title
            for newtitle in self.CountryList {
                let dict : Dictionary<String, String> = newtitle as! Dictionary<String, String>
                if dict["countryName"] == item[itemPosition].title {
                    self.SelectedNationalityID = dict["countryid"]! + "-" + self.SelectedNationalityName
                   
                }
            }
            
        
//        let dict : NSDictionary = self.CountryList[itemPosition] as! NSDictionary
//        self.SelectedNationalityID = dict.value(forKey: "countryid") as! String
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
             self.SelectedLivingInName = item[itemPosition].title
            for newtitle in self.CountryList {
                let dict : Dictionary<String, String> = newtitle as! Dictionary<String, String>
                if dict["countryName"] == item[itemPosition].title {
                    self.SelectedLivingInID = dict["countryid"]! + "-" + self.SelectedLivingInName
                 
                }
            }
            
           
//            let dict : NSDictionary = self.CountryList[itemPosition] as! NSDictionary
//            let countryID : String =  dict.value(forKey: "countryid") as! String
//            self.SelectedLivingInID =  countryID + "-" + self.SelectedLivingInName
            
            
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
           self.selectedService = item
            
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
            citizentextfield.startVisibleWithoutInteraction = true
            return true
        }
        if textField == livingIntextfield {
            livingIntextfield.startVisibleWithoutInteraction = true
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
  */
    @IBAction func searchButton(_ sender: UIButton) {
        self.SearchButtonMethod()
    }
    
    func SearchButtonMethod(){
        
        
        //"UK | Short Term Study Visa","UK | Tier 4 General Study Visa", "UK | IELTS Preparation Course","UK | Student Consultancy","USA | F1-Student Visa","Canada | Student Visa","Australia | Student Visa","Australia | RPL Dimploma"
        
        if selectedService == "UK | Short Term Study Visa" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com//leadForm/Short-Term-Study-Visa"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "30".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "Short Term Study Visa".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "30".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
            vc.requestBody = requestbody
            vc.NavigationTitle = "UK | Short Term Study Visa"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "UK | Tier 4 General Study Visa" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com//leadForm/Tier-4-General-Study-Visa"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "26".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "Tier 4 General Study Visa".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "26".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "UK | Tier 4 General Study Visa"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "UK | IELTS Preparation Course" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com//leadForm/IELTS-Preparation-Course"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "37".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "IELTS Preparation Course".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "37".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "UK | IELTS Preparation Course"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "UK | Student Consultancy" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com//leadForm/Student-Consultancy"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "29".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "Student Consultancy".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "29".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "UK | Student Consultancy"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "USA | F1-Student Visa" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://usa-immigrationhub.com//leadForm/F1-Student-Visa"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "29".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "F1-Student Visa".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "29".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "USA | F1-Student Visa"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "Canada | Student Visa" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://canada-immigrationhub.com//leadForm/Student-Visa"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "32".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "Student Visa".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "32".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "Canada | Student Visa"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "Australia | Student Visa" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://australia-immigrationhub.com/leadForm/Student-Visa"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "27".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "Student Visa".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "27".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "Australia | Student Visa"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if selectedService == "Australia | RPL Diploma" {
            let vc = webViewHeaderViewController.init(nibName: "webViewHeaderViewController", bundle: nil)
            vc.URLString = "https://australia-immigrationhub.com/leadForm/RPL-Diploma"
            let NiaEncoded = "&Nia=" + SelectedNationalityID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let LiaEncoded = "&Lia=" + SelectedLivingInID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let servicetypeEncoded = "&service_type=" + "34".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceNameencoded = "&service_name=" + "RPL Diploma".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let serviceTypeencoded = "serviceType=" + "34".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let requestbody : String = serviceTypeencoded + NiaEncoded + LiaEncoded + servicetypeEncoded + serviceNameencoded
             vc.requestBody = requestbody
            vc.NavigationTitle = "Australia | RPL Diploma"
            self.navigationController?.pushViewController(vc, animated: true)
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
