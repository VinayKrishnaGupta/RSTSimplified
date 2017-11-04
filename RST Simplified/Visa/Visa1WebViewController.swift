//
//  Visa1WebViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 31/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import WebKit

class Visa1WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    public var URLstring = String()
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: URLstring)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        webView.evaluateJavaScript("javascript:(function() { " +
            "var set = document.getElementsByTagName('wrap');"
            + "set[0].style.margin = '0px';" +
            "})()"
) { (result, error) in
            print(error)
            print(result)
        }
       
        
        
    }

    
}
