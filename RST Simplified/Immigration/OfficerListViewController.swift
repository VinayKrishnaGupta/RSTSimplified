//
//  OfficerListViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 28/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class OfficerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.GetConsultantData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if  ConsultationDataHandler.sharedInstance.ConsultantList.count != 0{
            return ConsultationDataHandler.sharedInstance.ConsultantList.count
        }
        else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OfficerProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OfficerProfileTableViewCell
        let dict : NSDictionary = ConsultationDataHandler.sharedInstance.ConsultantList[indexPath.section] as! NSDictionary
        cell.NameLabel.text = dict.value(forKeyPath: "per_name") as? String
        cell.designationLabel.text = dict.value(forKey: "per_designation") as? String
        let imageURLString : String = dict.value(forKey: "per_img") as! String
        cell.cellImageView.sd_setImage(with: URL(string:imageURLString), placeholderImage: UIImage.init(named: "profiledummy"))
        cell.addressLabel.text = dict.value(forKeyPath: "per_address") as? String
        let feesArray : Array<Any> = dict.value(forKeyPath: "modes") as! Array<Any>
        
        for item in feesArray {
            let dict2 : NSDictionary = item as! NSDictionary
            let feesName : String = (dict2.value(forKey: "mode_name") as? String)!
            let feesValue : String = (dict2.value(forKey: "mode_price") as? String)!
            cell.feeLabel.text = "Starts " + "USD " + feesValue
            
        }
        
        let descriptionLabel : String = dict.value(forKey: "per_about") as! String
        cell.descriptionLabel.text = "About" + ": " + descriptionLabel
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookingInformation", sender: self)
    }
    
    
    func GetConsultantData(){
        let HEADERS: HTTPHeaders = [
            
            "Accept": "application/json",
            "Token": "$2y$12$ryzJkF6ovr8Bny1Im4y2QeqzyvFV5ogAeHX8NM2J4O1bwCO4SwBbK"
            
        ]
        let parameter = ["process":"canada-immigrationhub.com","living_in":"124", "timezone" : "Asia/Kabul"]
       // Alamofire.request( URL(string:"https://rtg-rst.com/v1/scheduler/get-data/person")!, method: .post, parameters:parameter, headers: HEADERS )
        Alamofire.request(URL(string:"https://rtg-rst.com/v1/scheduler/get-data/person")!, method: .post, parameters: parameter, encoding: JSONEncoding.default , headers: HEADERS)
            .responseJSON { response in
                debugPrint(response)
                
                if let json = response.result.value {
                    print(json)
                    let dict = json as! NSDictionary
                    let type : String = dict.value(forKeyPath: "Response.status.type") as! String
                    if (type == "Success") {
                        ConsultationDataHandler.sharedInstance.ConsultantList = dict.value(forKeyPath: "Response.data.data") as! [Any]
                     self.tableView.reloadData()
                    }
                    else {
                        
                    }
                    
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
