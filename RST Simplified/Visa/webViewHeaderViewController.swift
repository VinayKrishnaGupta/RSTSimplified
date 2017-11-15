//
//  webViewHeaderViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 15/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD

class webViewHeaderViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webview: UIWebView!
    public var URLString = String()
    public var NavigationTitle = String()
    public var requestBody = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        webview.scrollView.bounces = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        let url = URL (string: self.URLString)
       var requestObj = URLRequest(url: url!)
       
        let postData: NSData = requestBody.data(using: String.Encoding.ascii, allowLossyConversion: true)! as NSData
        
        requestObj.httpBody = postData as Data
        requestObj.httpMethod = "POST"
        

      
        webview.loadRequest(requestObj)
        self.navigationItem.title = NavigationTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        //35 42 55
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // let url = URL (string: "https://uk-passporthub.com/")
        //        webview.loadHTMLString("javascript:(function() { " +
        //            "var nav = document.getElementsByTagName('wrap')[0];"
        //            + "nav.parentNode.removeChild(nav);" +
        //            "})()", baseURL: url)
        //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
        //            "var head = document.getElementsByTagName('wrap')[0];"
        //            + "head.parentNode.removeChild(head);" + "console.log('ashish');" +
        //            "})()")
        //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
        //            "var footer = document.getElementsByTagName('floatNone white')[0];"
        //            + "footer.parentNode.removeChild(footer);" +
        //            "})()")
        //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
        //            "var nav = document.getElementsByTagName('wrap')[0];"
        //            + "nav.parentNode.removeChild(nav);" +
        //            "})()")
        //        webview.stringByEvaluatingJavaScript(from: "document.getElementById('wrap').style.display = 'none';")
        
        webview.isHidden = true
        SVProgressHUD.show()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //        webview.stringByEvaluatingJavaScript(from: "document.getElementById('wrap').style.display = 'none';")
        //         webview.stringByEvaluatingJavaScript(from: "document.getElementById('main').style.display = 'none';")
        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
            "var head = document.getElementsByTagName('header')[0];"
            + "head.parentNode.removeChild(head);" + "console.log('vinay');" + "head.style.margin = '0px';" + "})()")
        
        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
            "var footer = document.getElementsByTagName('footer')[0];"
            + "footer.parentNode.removeChild(footer);" + "footer.style.margin = '0px';" + "})()")
        
        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
            "var nav = document.getElementsByTagName('nav')[0];"
            + "nav.parentNode.removeChild(nav);" + "nav.style.margin = '0px';" + "})()")
        
        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
            "var set = document.getElementsByClassName('banner');"
            + "set[0].style.margin = '0px';" +
            "})()")
        
        
        
        
        webview.isHidden = false
        SVProgressHUD.dismiss()
    }
    
    //    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
    //            "var head = document.getElementsByTagName('header')[0];"
    //            + "head.parentNode.removeChild(head);" + "console.log('ashish');" +
    //            "})()")
    //
    //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
    //            "var footer = document.getElementsByTagName('footer')[0];"
    //            + "footer.parentNode.removeChild(footer);" +
    //            "})()")
    //
    //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
    //            "var nav = document.getElementsByTagName('nav')[0];"
    //            + "nav.parentNode.removeChild(nav);" +
    //            "})()")
    //
    //        webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
    //            "var nav = document.getElementsByTagName('nav')[0];"
    //            + "nav.parentNode.removeChild(nav);" +
    //            "})()")
    //
    //        return true
    //    }
    
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

