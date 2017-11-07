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
import MRProgress

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
    var StateList = Array <Any>()
    var StateListNames = Array<String>()
    var CountryNamesList = Array<String>()
    var SelectedLivingInCountryID = String()
    let listofsampledata = ["A","B","C","D"]
    
    var SelectedCitizenOf = String()
    var SelectedDestination = String()
    var SelectedLivingInCountry = String()
    var SelectedLivinginState = String()
    
     var overlay = MRProgressOverlayView()
    override func viewDidLoad() {
        super.viewDidLoad()
        VisaRequiredForField.delegate = self
        CitizenOfField.delegate = self
        LivingInField.delegate = self
        StateField.delegate = self
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
        
        
        
        
        self.SetupDropDowns()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 232/256, green: 105/256, blue: 40/256, alpha: 1)
      
        self.setupDownArrowinDropdowns()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getListofCountries()
     //   MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
       
       
//        
//        
        
     overlay = MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
        overlay.tintColor = UIColor.lightGray
        overlay.titleLabel.textColor = UIColor.darkGray
        overlay.show(true)
        
        
        
       
    }
    
    func setupDownArrowinDropdowns() {
        VisaRequiredForField.rightViewMode = .always
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
        
        
        VisaRequiredForField.rightView = rightView
        LivingInField.rightView = rightView1
        CitizenOfField.rightView = rightView2
        StateField.rightView = rightView3
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
           self.SelectedDestination = item.replacingOccurrences(of: " ", with: "-")
            
        }
        CitizenDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.CitizenOfField.text = "  " + item
            self.SelectedCitizenOf = item.replacingOccurrences(of: " ", with: "-")
            
            
        }
        LivingInDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.LivingInField.text = "  " + item
            self.SelectedLivingInCountry = item.replacingOccurrences(of: " ", with: "-")
            let dict : NSDictionary = self.CountryList[index] as! NSDictionary
            self.SelectedLivingInCountryID = dict.value(forKey: "countryid") as! String
            self.getListofState()
            
        }
        StateDropdown.selectionAction = {
            
            [unowned self] (index: Int, item: String) in
            self.StateField.text = "  " + item
            self.SelectedLivinginState = item.replacingOccurrences(of: " ", with: "-")
            
            
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
        
        if SelectedCitizenOf == "Indonesia" {
            self.performSegue(withIdentifier: "indonesiaRGT", sender: nil)
        }
        
        if SelectedDestination == "United-Arab-Emirates" {
         //   self.performSegue(withIdentifier: "visaWebView", sender: nil)
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://uaevisa-online.org/" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else {
//            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
            
            
        self.performSegue(withIdentifier: "rgtvisa", sender: nil)
        }
     
        
        
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
                     self.overlay.dismiss(true)
                    print(dict)
                }
                else {
                    print("Error")
                }
                
        }
       
        
        
        
    }
    
    func getListofState(){
        
        Alamofire.request( URL(string: "http://api.rtgvisas-uae.com/api/getCountryState/getMaster?type=State&countryid=\(SelectedLivingInCountryID)")!, method: .get, parameters: nil, headers: nil )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.StateList = dict.value(forKey: "state") as! [Any]
                    self.StateListNames = dict.value(forKeyPath: "state.StateName") as! [String] 
                    self.StateDropdown.dataSource = self.StateListNames
                   
                    print(dict)
                }
                else {
                    print("Error")
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
        
        if segue.identifier == "indonesiaRGT" {
            let IndonesiaVC = segue.destination as! IndoesiaVisaRGTViewController
            IndonesiaVC.DestinationCountry = self.SelectedDestination
            IndonesiaVC.StateofIndonesia = self.SelectedLivinginState
        }
        if segue.identifier == "visaWebView" {
            let OtherVisaVC = segue.destination as! Visa1WebViewController
            if SelectedDestination == "United-Arab-Emirates" {
                OtherVisaVC.URLstring = "https://m.uaevisa-online.org" + "/" + self.SelectedLivingInCountry + "/" + self.SelectedCitizenOf
                
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
