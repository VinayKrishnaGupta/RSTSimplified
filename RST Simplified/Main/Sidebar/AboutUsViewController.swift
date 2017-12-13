//
//  AboutUsViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 12/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    public var NavigationTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NavigationTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        
        let rightbarbutton = UIBarButtonItem.init(image: UIImage.init(named: "home"), style: .done, target: self, action: #selector(HomeButton))
        self.navigationItem.rightBarButtonItem = rightbarbutton
        
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(HomeButton))
        self.navigationItem.leftBarButtonItem = backButton
        
        
    }
    
    func HomeButton() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
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
