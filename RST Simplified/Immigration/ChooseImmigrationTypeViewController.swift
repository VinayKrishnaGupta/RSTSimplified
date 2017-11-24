//
//  ChooseImmigrationTypeViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 13/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DropDown

class ChooseImmigrationTypeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ImmigrationTextField: UITextField!
    let ImmigrationDropDown = DropDown()
    var ListofServices = Array <String>()
    var SelectedService = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImmigrationTextField.delegate = self
        self.ListofServices = ["Australia","Canada","India","United Kingdom", "United States of America"]
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "Immigration Services"
        
        
        ImmigrationTextField.layer.cornerRadius = 10
        ImmigrationTextField.layer.borderColor = UIColor.darkGray.cgColor
        ImmigrationTextField.layer.borderWidth = 0.5
        ImmigrationTextField.layer.masksToBounds = true
        
         self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.SetupDropDowns()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ImmigrationTextField {
            ImmigrationDropDown.show()
            return false
        }
        else {
            return true
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        ImmigrationDropDown.hide()
        return false
    }
    @IBAction func searchButton(_ sender: UIButton) {
        self.SearchMethod()
    }
    func SearchMethod(){
        if SelectedService == "Australia" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://australia-immigrationhub.com/"
            vc.NavigationTitle = "Australia Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "Canada" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://canada-immigrationhub.com/"
            vc.NavigationTitle = "Canada Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "India" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://india-immigrationhub.com/"
            vc.NavigationTitle = "India Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if SelectedService == "United Kingdom" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://uk-immigrationhub.com/"
            vc.NavigationTitle = "UK Immigration"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if SelectedService == "United States of America" {
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://usa-immigrationhub.com/"
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
