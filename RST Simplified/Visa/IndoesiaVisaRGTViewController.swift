//
//  IndoesiaVisaRGTViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 03/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import WebKit

class IndoesiaVisaRGTViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    public var DestinationCountry = String()
    public var StateofIndonesia = String()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://rtgvisas-indonesia.com/Result/indonesia/" + DestinationCountry + "/" + "indonesia" + "/" + StateofIndonesia)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
}

