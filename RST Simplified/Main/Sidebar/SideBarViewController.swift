//
//  SideBarViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD


class SideBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableView: UITableView!
    let MenuItems = ["Home","Visa Services", "Passport Services","Immigration Services","Airport Services","Attestation Services","Student Services","Track Application","Contact Us"]
    let MenuItemsImageNames = ["home_service_final","visa_services_final","passport_final","immigration_final","airport_services_final","attestations_final","student_services_final","track_application_final","about_us"]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuItems.count
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = MenuItems[indexPath.section]
        
        
        cell.imageView?.image = UIImage.init(named: MenuItemsImageNames[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            
            sideMenuController?.performSegue(withIdentifier: "Home", sender: nil)
        }
       else if indexPath.section == 1 {
            
            let storyboard1 = UIStoryboard(name: "Visa", bundle: nil)
            let vc = storyboard1.instantiateViewController(withIdentifier: "chooseVisatype")
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            

        }
        else if indexPath.section == 2 {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://uk-passporthub.com"
            vc.NavigationTitle = "Passport Services"
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            
            
        }
        else if indexPath.section == 3 {
            
            let storyboard1 = UIStoryboard(name: "Immigration", bundle: nil)
            let vc = storyboard1.instantiateViewController(withIdentifier: "chooseImmigrationtype")
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            
            
        }
        else if indexPath.section == 4 {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "http://airportservices.co"
            vc.NavigationTitle = "Airport Services"
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            
            
            
        }
        else if indexPath.section == 5 {
            
            let vc = WebviewViewController.init(nibName: "WebviewViewController", bundle: nil)
            vc.URLString = "https://rst-attestation.com/"
            vc.NavigationTitle = "Attestation Services"
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            
            
            
        }
        else if indexPath.section == 6 {
            
            let storyboard1 = UIStoryboard(name: "Student", bundle: nil)
            let vc = storyboard1.instantiateViewController(withIdentifier: "StudentServiceType")
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            self.present(aObjNavi, animated: true, completion: nil)
            
            
        }
        
            
        else {
            SVProgressHUD.show(withStatus: "Coming Soon...")
            SVProgressHUD.dismiss(withDelay: 2)
        }
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Home" {
            if let nextViewController = segue.destination as? FirstScreenViewController{
                nextViewController.buttonNameofHomePage = "VisaButton"
               
                
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

