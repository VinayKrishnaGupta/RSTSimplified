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
import SVProgressHUD


class ChooseVisaTypeViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
  
    
    @IBOutlet weak var VisaRequiredForField: UITextField!
    
    @IBOutlet weak var CitizenOfField: UITextField!
    
    @IBOutlet weak var LivingInField: UITextField!
    
    @IBOutlet weak var StateField: UITextField!
    
    let VisaRequiredDropdown = DropDown()
    
    @IBOutlet weak var stateLabel: UILabel!
    let CitizenDropdown = DropDown()
    let LivingInDropdown = DropDown()
    let StateDropdown = DropDown()
    var CountryList = Array<Any>()
    var CountryListCitizenOf = Array<Any>()
    var CountryListLivingIn = Array<Any>()
    var StateList = Array <Any>()
    var StateListNames = Array<String>()
    var CountryNamesList = Array<String>()
    var CountryNameListCitizenOf = Array<String>()
    var CountryNameLivingIn = Array<String>()
    
    var SelectedLivingInCountryID = String()
    var listofsampledata = Array<String>()
    
    var SelectedCitizenOf = String()
    var SelectedDestination = String()
    var SelectedLivingInCountry = String()
    var SelectedLivinginState = String()
    
    
    //Picker
    private var myUIPicker: UIPickerView!
    private var LivingINPicker: UIPickerView!
    private var CitizenPicker: UIPickerView!
    private var StatesPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
      //  VisaRequiredForField.delegate = self
//        CitizenOfField.delegate = self
//        LivingInField.delegate = self
//        StateField.delegate = self
        VisaRequiredForField.layer.cornerRadius = 10
        VisaRequiredForField.layer.borderColor = UIColor.darkGray.cgColor
        VisaRequiredForField.layer.borderWidth = 0.5
        VisaRequiredForField.layer.masksToBounds = true
        
        CitizenOfField.layer.cornerRadius = 10
        CitizenOfField.layer.borderColor = UIColor.darkGray.cgColor
        CitizenOfField.layer.borderWidth = 0.5
        CitizenOfField.layer.masksToBounds = true
        
        LivingInField.layer.cornerRadius = 10
        LivingInField.layer.borderColor = UIColor.darkGray.cgColor
        LivingInField.layer.borderWidth = 0.5
        LivingInField.layer.masksToBounds = true
        
        StateField.layer.cornerRadius = 10
        StateField.layer.borderColor = UIColor.darkGray.cgColor
        StateField.layer.borderWidth = 0.5
        StateField.layer.masksToBounds = true
       
        //Pickers
        myUIPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        myUIPicker.dataSource = self
        myUIPicker.delegate = self
        self.myUIPicker.backgroundColor = UIColor.groupTableViewBackground
        VisaRequiredForField.inputView = myUIPicker
        
        CitizenPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        CitizenPicker.dataSource = self
        CitizenPicker.delegate = self
        CitizenPicker.backgroundColor = UIColor.groupTableViewBackground
        CitizenOfField.inputView = CitizenPicker
        
        LivingINPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        LivingINPicker.dataSource = self
        LivingINPicker.delegate = self
        LivingINPicker.backgroundColor = UIColor.groupTableViewBackground
        LivingInField.inputView = LivingINPicker
      
        
        StatesPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        StatesPicker.dataSource = self
        StatesPicker.delegate = self
        StatesPicker.backgroundColor = UIColor.groupTableViewBackground
        StateField.inputView = StatesPicker
        StatesPicker.sizeToFit()
     
        
        //PickerToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(red: 0.0, green: 122/255, blue: 1, alpha: 1)
        toolBar.backgroundColor = UIColor.white
         toolBar.sizeToFit()
      //  toolBar.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 100)
       
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ChooseVisaTypeViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ChooseVisaTypeViewController.cancelClick))
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
         doneButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
       
        CitizenOfField.inputAccessoryView = toolBar
        LivingInField.inputAccessoryView = toolBar
        StateField.inputAccessoryView = toolBar
        VisaRequiredForField.inputAccessoryView = toolBar
        
        
       // self.SetupDropDowns()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
      
      //  self.setupDownArrowinDropdowns()

        // Do any additional setup after loading the view.
    }
    
    func doneClick() {
        let indexpath = myUIPicker.selectedRow(inComponent: 0)
        if indexpath>0 {
             VisaRequiredForField.text = " " + CountryNamesList[indexpath]
            self.SelectedDestination = CountryNamesList[indexpath].replacingOccurrences(of: " ", with: "-")
            self.getListofNationality()
            
            
            if CitizenPicker.selectedRow(inComponent: 0)>0 {
                let indexpath1 = CitizenPicker.selectedRow(inComponent: 0)
                CitizenOfField.text = " " + CountryNameListCitizenOf[indexpath1]
                self.SelectedCitizenOf = CountryNameListCitizenOf[indexpath1].replacingOccurrences(of: " ", with: "-")
                self.getListofLivingInCountry()
                
                let indexpath2 = LivingINPicker.selectedRow(inComponent: 0)
                if indexpath2>0{
                    LivingInField.text = CountryNameLivingIn[indexpath2]
                    
                    self.SelectedLivingInCountry = CountryNameLivingIn[indexpath2].replacingOccurrences(of: " ", with: "-")
                    
                    let dict : NSDictionary = self.CountryListLivingIn[indexpath2] as! NSDictionary
                    
                    if self.SelectedDestination == "United-Arab-Emirates" || self.SelectedDestination == "Singapore" || self.SelectedDestination == "Iran" || self.SelectedDestination == "Oman" || self.SelectedDestination == "United-States-Of-America" {
                        self.SelectedLivingInCountryID = dict.value(forKey: "id") as! String
                    }
                    else {
                        self.SelectedLivingInCountryID = dict.value(forKey: "countryid") as! String
                    }
                    self.getListofState()
                    
                    let indexpath3 = StatesPicker.selectedRow(inComponent: 0)
                    if indexpath3>0 {
                        StateField.text = " " + StateListNames[indexpath3]
                        self.SelectedLivinginState = StateListNames[indexpath3].replacingOccurrences(of: " ", with: "-")
                    }
                }
                
                
            }
            
        }
       
        
        
        
        
       
        
       
        
        
        VisaRequiredForField.resignFirstResponder()
        CitizenOfField.resignFirstResponder()
        LivingInField.resignFirstResponder()
        StateField.resignFirstResponder()
    }
    
   
    
    
    
    
    
    func cancelClick() {
        VisaRequiredForField.resignFirstResponder()
        CitizenOfField.resignFirstResponder()
        LivingInField.resignFirstResponder()
        StateField.resignFirstResponder()
      
        
    }
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == myUIPicker {
            if CountryNamesList.count > 0 {
                return CountryNamesList[row]
            }
            else {
                return nil
            }
           
        }
        else if pickerView == CitizenPicker {
            if CountryNameListCitizenOf.count>0{
               return CountryNameListCitizenOf[row]
            }
            else {
                return nil
            }
           
        }
        else if pickerView == LivingINPicker {
            if CountryNameLivingIn.count>0 {
               return CountryNameLivingIn[row]
            }
            else {
                return nil
            }
           
        }
        else if pickerView == StatesPicker {
            if StateListNames.count>0 {
              return StateListNames[row]
            }
            else {
                return nil
            }
           
        }
        else {
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      
        if pickerView == myUIPicker {
           // VisaRequiredForField.text = " " + CountryNamesList[row]
            //  myUIPicker.removeFromSuperview()
        }
        else if pickerView == CitizenPicker {
           
        }
        else if pickerView == LivingINPicker {
           
        }
        else if pickerView == StatesPicker {
           
        }
        
        
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == myUIPicker {
           return CountryNamesList.count
        }
        else if pickerView == CitizenPicker {
            return CountryNameListCitizenOf.count
        }
        else if pickerView == LivingINPicker {
            return CountryNameLivingIn.count
        }
        else if pickerView == StatesPicker {
            return StateListNames.count
        }
        else {
            return 0
        }
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.getListofCountries()
     //   MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
       
       
//        
//        
        
//     overlay = MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
//        overlay.tintColor = UIColor.lightGray
//        overlay.titleLabel.textColor = UIColor.darkGray
//        overlay.show(true)
//
        
        
       
    }
    
    func setupDownArrowinDropdowns() {
    //    VisaRequiredForField.rightViewMode = .always
        LivingInField.rightViewMode = .always
        CitizenOfField.rightViewMode = .always
        StateField.rightViewMode = .always
        
        let rightView = UIView.init(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        let rightView1 = UIView.init(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        let rightView2 = UIView.init(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        let rightView3 = UIView.init(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        let imageName = "downarrow"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 5, width: 15, height: 15)
        rightView.addSubview(imageView)
        
        let imageName1 = "downarrow"
        let image1 = UIImage(named: imageName1)
        let imageView1 = UIImageView(image: image1!)
        imageView1.frame = CGRect(x: 0, y: 5, width: 15, height: 15)
        rightView1.addSubview(imageView1)
        
        let imageName2 = "downarrow"
        let image2 = UIImage(named: imageName2)
        let imageView2 = UIImageView(image: image2!)
        imageView2.frame = CGRect(x: 0, y: 5, width: 15, height: 15)
        rightView2.addSubview(imageView2)
        
        let imageName3 = "downarrow"
        let image3 = UIImage(named: imageName3)
        let imageView3 = UIImageView(image: image3!)
        imageView3.frame = CGRect(x: 0, y: 5, width: 15, height: 15)
        rightView3.addSubview(imageView3)
        
        
     //   VisaRequiredForField.rightView = rightView
        LivingInField.rightView = rightView1
        CitizenOfField.rightView = rightView2
        StateField.rightView = rightView3
    }
    
    
    
    func SetupDropDowns() {
//        VisaRequiredDropdown.anchorView = VisaRequiredForField
//        VisaRequiredDropdown.dataSource = listofsampledata
//        VisaRequiredDropdown.direction = .bottom
       
        
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
          //  self.VisaRequiredForField.text = "  " + item
           self.SelectedDestination = item.replacingOccurrences(of: " ", with: "-")
            self.getListofNationality()
            
            
            
        }
        CitizenDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.CitizenOfField.text = "  " + item
            self.SelectedCitizenOf = item.replacingOccurrences(of: " ", with: "-")
            self.getListofLivingInCountry()
            
        }
        LivingInDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.LivingInField.text = "  " + item
            self.SelectedLivingInCountry = item.replacingOccurrences(of: " ", with: "-")
           
            let dict : NSDictionary = self.CountryList[index] as! NSDictionary
            
            if self.SelectedDestination == "United-Arab-Emirates" || self.SelectedDestination == "Singapore" || self.SelectedDestination == "Iran" || self.SelectedDestination == "Oman" || self.SelectedDestination == "United-States-Of-America" {
                self.SelectedLivingInCountryID = dict.value(forKey: "id") as! String
            }
            else {
                self.SelectedLivingInCountryID = dict.value(forKey: "countryid") as! String
            }
             self.getListofState()
        }
        
            
        
        StateDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.StateField.text = "  " + item
            self.SelectedLivinginState = item.replacingOccurrences(of: " ", with: "-")
            
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == VisaRequiredForField {
//
//            self.view.addSubview(myUIPicker)
//
//          //  VisaRequiredDropdown.show()
//            return false
//        }
        if textField == LivingInField {
            self.view.addSubview(LivingINPicker)
            
//            LivingInDropdown.show()
//            VisaRequiredDropdown.hide()
//            CitizenDropdown.hide()
//            StateDropdown.hide()
            return false
        }
        if textField == CitizenOfField {
            self.view.addSubview(CitizenPicker)
//            LivingInDropdown.hide()
//            VisaRequiredDropdown.hide()
//            CitizenDropdown.show()
//            StateDropdown.hide()
            return false
        }
        if textField == StateField {
            self.view.addSubview(StatesPicker)
//            LivingInDropdown.hide()
//            VisaRequiredDropdown.hide()
//            CitizenDropdown.hide()
//            StateDropdown.show()
            return false
        }
        else {
            return true
        }
        
        
        
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        LivingInDropdown.hide()
       // VisaRequiredDropdown.hide()
        CitizenDropdown.hide()
        StateDropdown.hide()
       // myUIPicker.removeFromSuperview()
        CitizenPicker.removeFromSuperview()
        LivingINPicker.removeFromSuperview()
        StatesPicker.removeFromSuperview()
        
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
        
        if SelectedCitizenOf == "Indonesia" {
             let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://rtgvisas-indonesia.com/Result/indonesia/" + SelectedDestination + "/" + SelectedLivingInCountry + "/" + SelectedLivinginState
            self.navigationController?.pushViewController(vc, animated: true)
            //self.performSegue(withIdentifier: "indonesiaRGT", sender: nil)
        }
        
       else if SelectedDestination == "United-Arab-Emirates" {
         //   self.performSegue(withIdentifier: "visaWebView", sender: nil)
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://uaevisa-online.org/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else if SelectedDestination == "Singapore" {
            //https://m.singaporevisa-online.org/
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://singaporevisa-online.org/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       else if SelectedDestination == "United-States-Of-America" {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://usa-visahub.com/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf + "/" + self.SelectedLivinginState
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       else if SelectedDestination == "Oman" {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://omanvisas.org/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
       else if SelectedDestination == "Iran" {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://iranvisas.org/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf + "/" + "Tourism"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
            
        
        else {
//            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
            if SelectedLivinginState != "" {
                let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
                vc.URLString = "http://rst.rtgvisas.com/Result/" + SelectedCitizenOf + "/" + SelectedDestination + "/" + SelectedLivingInCountry + "/" + SelectedLivinginState
                self.navigationController?.pushViewController(vc, animated: true)
               // self.performSegue(withIdentifier: "rgtvisa", sender: nil)
            }
            else{
                print("Please Select States")
            }
            
        
        }
     
        
        
    }
    
    func getListofCountries(){
        if UserDefaults.standard.value(forKeyPath: "CountryList") != nil {
            self.CountryNamesList = UserDefaults.standard.value(forKey: "CountryNamesList") as! [String]
            self.CountryList = UserDefaults.standard.value(forKeyPath: "CountryList") as! [Any]
            self.VisaRequiredDropdown.dataSource = self.CountryNamesList
            self.CitizenDropdown.dataSource = self.CountryNamesList
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
                    self.VisaRequiredDropdown.dataSource = self.CountryNamesList
                    self.CitizenDropdown.dataSource = self.CountryNamesList
                    // self.LivingInDropdown.dataSource = self.CountryNamesList
                   
                    print(dict)
                }
                
        }
                
                
        }
        
                
        }
       
        
        
        
    
    func getListofNationality() {
        var URLString = String()
        var parshingtype = String()
        SVProgressHUD.show()
        if SelectedDestination == "United-Arab-Emirates" {
            StateField.isHidden = true
            stateLabel.isHidden = true
            URLString = "https://uaevisa-online.org/api/getData1.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=nationality"
            parshingtype = "country.name"
        }
            
        else if SelectedDestination == "Singapore" {
            StateField.isHidden = true
            stateLabel.isHidden = true
            URLString = "http://singaporevisa-online.org/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=nationality"
            parshingtype = "country.name"
        }
            
        else if SelectedDestination == "Iran" {
            StateField.isHidden = true
            stateLabel.isHidden = true
            URLString = "http://iranvisas.org/api/getdatairn.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=nationality"
            parshingtype = "country.name"
        }
            
        else if SelectedDestination == "Oman" {
            StateField.isHidden = true
            stateLabel.isHidden = true
            URLString = "http://omanvisas.org/api/getdataomn.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=nationality"
            parshingtype = "country.name"
        }
        else if SelectedDestination == "United-States-Of-America" {
            StateField.isHidden = false
            stateLabel.isHidden = false
            URLString = "https://usa-visahub.com/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=nationality"
            parshingtype = "country.name"
        }
            
        else {
            StateField.isHidden = false
            stateLabel.isHidden = false
            URLString = "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?Type=COUNTRY&CountryId="
            parshingtype = "country.countryName"
        }
        
        
        
        Alamofire.request( URL(string: URLString)!, method: .get, parameters: nil, headers: nil )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.CountryListCitizenOf = dict.value(forKeyPath: "country") as! [Any]
                    
                    
                    self.CountryNameListCitizenOf = dict.value(forKeyPath: parshingtype) as! [String]
                    
                   
                    //self.CitizenDropdown.dataSource = self.CountryNamesList
                    SVProgressHUD.dismiss()
                    print(dict)
                }
                else {
                    print("Error")
                }
                
        
        
        
        
        
    }
    }
    
    func getListofLivingInCountry(){
        SVProgressHUD.show()
       var URLString = String()
        var parshingtype = String()
        
        if SelectedDestination == "United-Arab-Emirates" {
            URLString = "https://uaevisa-online.org/api/getData1.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=livingIn"
            parshingtype = "country.name"
        }
        
       else if SelectedDestination == "Singapore" {
            URLString = "http://singaporevisa-online.org/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=livingIn"
            parshingtype = "country.name"
        }
        
       else if SelectedDestination == "Iran" {
            URLString = "http://iranvisas.org/api/getdatairn.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=livingIn"
            parshingtype = "country.name"
        }

       else if SelectedDestination == "Oman" {
            URLString = "http://omanvisas.org/api/getdataomn.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=livingIn"
            parshingtype = "country.name"
        }
       else if SelectedDestination == "United-States-Of-America" {
            URLString = "https://usa-visahub.com/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=country&requireData=livingIn"
            parshingtype = "country.name"
        }
        
        else {
            
            URLString = "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?Type=COUNTRY&CountryId="
            parshingtype = "country.countryName"
        }
        
        
        
        Alamofire.request( URL(string: URLString)!, method: .get, parameters: nil, headers: ["Content-Type":"application/json"])
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.CountryListLivingIn = dict.value(forKeyPath: "country") as! [Any]
                   
                    
                    self.CountryNameLivingIn = dict.value(forKeyPath: parshingtype) as! [String]
                    
                   
                 //   self.LivingInDropdown.dataSource = self.CountryNamesList
                   SVProgressHUD.dismiss()
                    print(dict)
                }
                else {
                    print("Error")
                }
                
        }
        
        
    }
    
    
    
    func getListofState(){
        
        
        if SelectedDestination == "United-States-Of-America" {
            SVProgressHUD.show()
            StateField.isHidden = false
            stateLabel.isHidden = false
            let parameter1 = ["LivingInId" : self.SelectedLivingInCountryID]
            
            let HEADERS: HTTPHeaders = [
                
                "Accept": "application/json",
                
            ]
            
            Alamofire.request( URL(string:"https://usa-visahub.com/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=state")!, method: .post, parameters: parameter1, headers: HEADERS )
            
            
         //   Alamofire.request( URL(string: "https://usa-visahub.com/api/getdata.php?secure_id=nAN9qJlcBAR%2Fzs0R%2BZHJmII0W7GFPuRzY%2BfyrT65Fyw%3D&gofor=state")!, method:.post, parameters: ["LivingInId" : self.SelectedLivingInCountryID as Any], encoding: .JSON, headers: nil)
                
                
                .responseJSON { response in
                    debugPrint(response)
                    
                    
                    if let json = response.result.value {
                        let dict = json as! NSDictionary
                        self.StateList = dict.value(forKey: "state") as! [Any]
                        self.StateListNames = dict.value(forKeyPath: "state.StateName") as! [String]
                      //  self.StateDropdown.dataSource = self.StateListNames
                        SVProgressHUD.dismiss()
                        print(dict)
                    }
                    else {
                        print("Error")
                    }
                    
            }
            
            
            
        }
       else if SelectedDestination == "United-Arab-Emirates" || SelectedDestination == "Singapore" || SelectedDestination == "Iran" || SelectedDestination == "Oman" {
         StateField.isHidden = true
        stateLabel.isHidden = true
            
        }
        else {
            SVProgressHUD.show()
            StateField.isHidden = false
            stateLabel.isHidden = false
            Alamofire.request( URL(string: "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?type=State&countryid=\(SelectedLivingInCountryID)")!, method: .get, parameters: nil, headers: nil )
                
                
                .responseJSON { response in
                    debugPrint(response)
                    
                    
                    if let json = response.result.value {
                        let dict = json as! NSDictionary
                        self.StateList = dict.value(forKey: "state") as! [Any]
                        self.StateListNames = dict.value(forKeyPath: "state.StateName") as! [String]
                        self.StateDropdown.dataSource = self.StateListNames
                        SVProgressHUD.dismiss()
                        print(dict)
                    }
                    else {
                        print("Error")
                        SVProgressHUD.dismiss()
                    }
                    
            }
        }
        
        
        
        
        
        
     
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rgtvisa" {
            let RGTVC = segue.destination as! RTGVisasViewController
            RGTVC.Citizenof = self.SelectedCitizenOf
            RGTVC.DestinationCountry = self.SelectedDestination
            RGTVC.LivingInCountry = self.SelectedLivingInCountry
            RGTVC.livingInState = self.SelectedLivinginState
        }
        
       else if segue.identifier == "indonesiaRGT" {
            let IndonesiaVC = segue.destination as! IndoesiaVisaRGTViewController
            IndonesiaVC.DestinationCountry = self.SelectedDestination
            IndonesiaVC.StateofIndonesia = self.SelectedLivinginState
        }
       else if segue.identifier == "visaWebView" {
            let OtherVisaVC = segue.destination as! Visa1WebViewController
            if SelectedDestination == "United-Arab-Emirates" {
                OtherVisaVC.URLstring = "https://uaevisa-online.org" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
                
            }
           else if SelectedDestination == "Singapore" {
                OtherVisaVC.URLstring = "https://singaporevisa-online.org" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
                
            }
            else if SelectedDestination == "Iran" {
                OtherVisaVC.URLstring = "https://iranvisas.org" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
                
            }
            else if SelectedDestination == "Oman" {
                OtherVisaVC.URLstring = "https://omanvisas.org" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
                
            }
            else if SelectedDestination == "United-States-Of-America" {
                OtherVisaVC.URLstring = "https://usa-visahub.com" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf + "/" + self.SelectedLivinginState
                
            }
            else {
                 OtherVisaVC.URLstring =  "http://rst.rtgvisas.com/Result/" + SelectedCitizenOf + "/" + SelectedDestination + "/" + SelectedLivingInCountry + "/" + SelectedLivinginState
            }
            
            
            
        }
        
}

    
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
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
