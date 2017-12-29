//
//  OfficerListViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 28/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

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
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OfficerProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OfficerProfileTableViewCell
        
        return cell
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
