//
//  ChooseImmigrationTypeViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 13/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DropDown
import SVProgressHUD

class ChooseImmigrationTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var ImmigrationTextField: UITextField!
    @IBOutlet weak var citizenofTextField: UITextField!
    @IBOutlet weak var livinginTextField: UITextField!
    
    let ImmigrationDropDown = DropDown()
    var ListofServices = Array <String>()
    var CountryNamesList = Array <String>()
    var SelectedService = String()
    var SelectedNationalityName = String()
    var SelectedLivingInName = String()
    private var CitizenPicker: UIPickerView!
    private var LivingINPicker: UIPickerView!
    private var ServicesPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ListofServices = ["Select One", "Australia","Canada","India","United Kingdom", "United States of America"]
        self.CountryNamesList = ["Aruba","Afghanistan","Angola","Anguilla","Albania","Andorra","Netherlands Antilles","United Arab Emirates","Argentina","Armenia","American Samoa","Antartica","French Southern Territories","Antigua And Barbuda","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bahamas","Bosnia and Herzegovina","Belarus","Belize","Bermuda","Bolivia","Brazil","Barbados","Brunei","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote-d-Ivorire","Cameroon","Republic Of Congo","Cook Islands","Colombia","Comoros","Cape verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Czech Republic","Germany","Djibouti","Dominica","Denmark","Dominican Republic","Algeria","Ecuador","Egypt","Eritrea","Western Sahara","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia","Gabon","United Kingdom","Georgia","Ghana","Gibraltar","Guinea","Guadeloupe","Gambia","Guinea Bissau","Equatorial Guinea","Greece","Grenada","Greenland","Guatemala","French Guiana","Guyana","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrghyzstan","Cambodia","Kiribati","Saint Kitts And Nevis","South Korea","Kuwait","Laos","Lebanon","Liberia","Libya","Saint Lucia","Liechtenstein","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Morocco","Monaco","Moldova","Madagascar","Maldives","Mexico","Marshall Islands","Macedonia","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Montserrat","Martinique","Mauritius","Malawi","Malaysia","Mayotte","Namibia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","Nauru","New Zealand","Oman","Pakistan","Panama","Peru","Phillippines","Palau","Papua New Guinea","Poland","Puerto Rico","North Korea","Portugal","Paraguay","Palestine","French Polynesia","Qatar","Reunion Islands","Romania","Russia","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","South Georgia And The South Sandwich Islands","Saint Helena","Svalbard and Jan Mayen","Solomon Islands","Sierra Leone","El Salvador","San Marino","Somalia","Serbia","South Sudan","Sao Tome And Principe","Suriname","Slovakia","Slovenia","Sweden","Swaziland","Seychelles","Syria","Turks And Caicos Islands","Chad","Togo","Thailand","Tajikistan","Turkmenistan","East Timor","Tonga","Trinidad And Tobago","Tunisia","Turkey","Tuvalu","Taiwan","Tanzania","Uganda","Ukraine","Uruguay","United States Of America","Uzbekistan","Vatican City","Saint Vincent And The Grenadines","Venezuela","Vietnam","Vanuatu","Samoa","Yemen","South Africa","Zambia","Zimbabwe","Congo","Hong Kong","Macao","British Virgin Islands","Bouvet Island","British Indian Ocean Territory","Falkland Islands","Faroe Islands","Guam","Heard Island and Mcdonald Islands","Isle of Man","New Caledonia","Niue","Norfolk Island","Northern Mariana Islands","Pitcairn","Saint Pierre and Miquelon","Timor-leste","Tokelau","Virgin Islands","Wallis and Futuna"]
        
        
        
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        let VideoCalling : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "videocalling"), style: .done, target: self, action: #selector(VideoCallingMethod))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = VideoCalling
        self.navigationItem.title = "Immigration"
        
        citizenofTextField.layer.cornerRadius = 10
        citizenofTextField.layer.borderColor = UIColor.darkGray.cgColor
        citizenofTextField.layer.borderWidth = 0.5
        citizenofTextField.layer.masksToBounds = true
        livinginTextField.layer.cornerRadius = 10
        livinginTextField.layer.borderColor = UIColor.darkGray.cgColor
        livinginTextField.layer.borderWidth = 0.5
        livinginTextField.layer.masksToBounds = true
        ImmigrationTextField.layer.cornerRadius = 10
        ImmigrationTextField.layer.borderColor = UIColor.darkGray.cgColor
        ImmigrationTextField.layer.borderWidth = 0.5
        ImmigrationTextField.layer.masksToBounds = true
        
         self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
       
        
        // Do any additional setup after loading the view.
    }
    func SetUpPickers(){
        
        CitizenPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        CitizenPicker.dataSource = self
        CitizenPicker.delegate = self
        CitizenPicker.backgroundColor = UIColor.groupTableViewBackground
        citizenofTextField.inputView = CitizenPicker
        
        LivingINPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        LivingINPicker.dataSource = self
        LivingINPicker.delegate = self
        LivingINPicker.backgroundColor = UIColor.groupTableViewBackground
        livinginTextField.inputView = LivingINPicker
        
        
        ServicesPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        ServicesPicker.dataSource = self
        ServicesPicker.delegate = self
        ServicesPicker.backgroundColor = UIColor.groupTableViewBackground
        ImmigrationTextField.inputView = ServicesPicker
        ServicesPicker.sizeToFit()
        
        //PickerToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(red: 0.0, green: 122/255, blue: 1, alpha: 1)
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        
        
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ChooseImmigrationTypeViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ChooseImmigrationTypeViewController.cancelClick))
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        doneButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        
        
        citizenofTextField.inputAccessoryView = toolBar
        livinginTextField.inputAccessoryView = toolBar
        ImmigrationTextField.inputAccessoryView = toolBar
        
        
        
        
    }
    func doneClick() {
        let indexpath = CitizenPicker.selectedRow(inComponent: 0)
        if indexpath>0 {
            citizenofTextField.text = " " + CountryNamesList[indexpath]
            self.SelectedNationalityName = CountryNamesList[indexpath].replacingOccurrences(of: " ", with: "")
        }
         let indexpath1 = LivingINPicker.selectedRow(inComponent: 0)
        if indexpath1>0 {
            livinginTextField.text = " " + CountryNamesList[indexpath1]
            self.SelectedLivingInName = CountryNamesList[indexpath1].replacingOccurrences(of: " ", with: "")
        }
        let indexpath2 = ServicesPicker.selectedRow(inComponent: 0)
        if indexpath2>0 {
            ImmigrationTextField.text = " " + ListofServices[indexpath2]
            self.SelectedService = ListofServices[indexpath2]
        }
        
        citizenofTextField.resignFirstResponder()
        livinginTextField.resignFirstResponder()
        ImmigrationTextField.resignFirstResponder()
        
        
        
    }
    
    func cancelClick() {
        citizenofTextField.resignFirstResponder()
        livinginTextField.resignFirstResponder()
        ImmigrationTextField.resignFirstResponder()
        
        
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
            if ListofServices.count>0 {
                return ListofServices[row]
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
            return ListofServices.count
        }
            
        else {
            return 0
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      self.SetUpPickers()
    }
    func SetupDropDowns() {
        ImmigrationDropDown.anchorView = ImmigrationTextField
        ImmigrationDropDown.dataSource = ListofServices
        ImmigrationDropDown.direction = .any
        
        let rightView = UIView.init(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        let imageName = "downarrow"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 5, width: 15, height: 15)
        rightView.addSubview(imageView)
        ImmigrationTextField.rightView = rightView
        
        ImmigrationDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.ImmigrationTextField.text = " " + item
            self.SelectedService = item
            
        }
        
    }
    
    func BackButtonmethod() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func VideoCallingMethod(){
        print("video calling method")
        self.performSegue(withIdentifier: "chooseOnlineConsultation", sender: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        if SelectedLivingInName.isEmpty || SelectedNationalityName.isEmpty || SelectedService.isEmpty {
            SVProgressHUD.showError(withStatus: "All Fields are Mandetory")
            SVProgressHUD.dismiss(withDelay: 2)
        }
        else {
              self.SearchMethod()
        }
        
      
    }
    func SearchMethod(){
        if SelectedService == "Australia" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://australia-immigrationhub.com/" + SelectedNationalityName + "/" + SelectedLivingInName
            vc.NavigationTitle = "Australia Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "Canada" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://canada-immigrationhub.com/" + SelectedNationalityName + "/" + SelectedLivingInName
            vc.NavigationTitle = "Canada Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "India" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://india-immigrationhub.com/"
            vc.NavigationTitle = "India Immigration" + SelectedNationalityName + "/" + SelectedLivingInName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if SelectedService == "United Kingdom" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com/" + SelectedNationalityName + "/" + SelectedLivingInName
            vc.NavigationTitle = "UK Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "United States of America" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://usa-immigrationhub.com/" + SelectedNationalityName + "/" + SelectedLivingInName
            vc.NavigationTitle = "USA Immigration"
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
