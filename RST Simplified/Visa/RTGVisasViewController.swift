//
//  RTGVisasViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 02/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import WebKit


class RTGVisasViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    public var Citizenof = String()
    public var DestinationCountry = String()
    public var LivingInCountry = String()
    public var livingInState = String()
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        let myURL = URL(string: "http://rst.rtgvisas.com/Result/" + Citizenof + "/" + DestinationCountry + "/" + LivingInCountry + "/" + livingInState)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    
    
    
}

