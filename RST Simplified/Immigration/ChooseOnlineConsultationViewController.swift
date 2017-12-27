//
//  ChooseOnlineConsultationViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 22/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class ChooseOnlineConsultationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var selectServiceTextField: UITextField!
    @IBOutlet weak var LivingInTextField: UITextField!
    var ListofServices = Array <String>()
    var CountryNamesList = Array <String>()
    private var LivingINPicker: UIPickerView!
    private var ServicesPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ListofServices = ["Select One", "Canada", "India", "United Kingdom","United States of America"]

        selectServiceTextField.layer.cornerRadius = 10
        selectServiceTextField.layer.borderColor = UIColor.darkGray.cgColor
        selectServiceTextField.layer.borderWidth = 0.5
        selectServiceTextField.layer.masksToBounds = true
        LivingInTextField.layer.cornerRadius = 10
        LivingInTextField.layer.borderColor = UIColor.darkGray.cgColor
        LivingInTextField.layer.borderWidth = 0.5
        LivingInTextField.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.GetLivingInCountries()
        
    }
    

    
    func GetLivingInCountries() {
       // let parameter1 = ["LivingInId" : ""]
        
        let HEADERS: HTTPHeaders = [
            
            "Accept": "application/json",
            "Token": "$2y$12$ryzJkF6ovr8Bny1Im4y2QeqzyvFV5ogAeHX8NM2J4O1bwCO4SwBbK"
            
            ]
        
        Alamofire.request( URL(string:"https://rtg-rst.com/v1/scheduler/get-data/country")!, method: .post, parameters:nil, headers: HEADERS )
            .responseJSON { response in
                debugPrint(response)
                
                if let json = response.result.value {
                    print(json)
                    let dict = json as! NSDictionary
                    let type : String = dict.value(forKeyPath: "Response.status.type") as! String
                    if (type == "Success") {
                        self.CountryNamesList = dict.value(forKeyPath: "Response.data.data.countryName") as! [String]
                        self.SetUpPickers()
                        
                    }
                    else {
                        
                    }
                    
                }
    }
    }
    
    
    func SetUpPickers(){
        
       
        
        LivingINPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        LivingINPicker.dataSource = self
        LivingINPicker.delegate = self
        LivingINPicker.backgroundColor = UIColor.groupTableViewBackground
        LivingInTextField.inputView = LivingINPicker
        
        
        ServicesPicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        ServicesPicker.dataSource = self
        ServicesPicker.delegate = self
        ServicesPicker.backgroundColor = UIColor.groupTableViewBackground
        selectServiceTextField.inputView = ServicesPicker
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
        
        
        
        
        
        selectServiceTextField.inputAccessoryView = toolBar
        LivingInTextField.inputAccessoryView = toolBar
        
        
        
        
        
    }
    func doneClick() {
        
    }
    func cancelClick() {
        
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == LivingINPicker {
            return CountryNamesList.count
        }
        else if pickerView == ServicesPicker {
            return ListofServices.count
        }
            
        else {
            return 0
        }
        
     }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
         if pickerView == LivingINPicker {
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
