//
//  WebviewViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 07/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD
import MRProgress

class WebviewViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webview: UIWebView!
    public var URLString = String()
    public var NavigationTitle = String()
    var overlay = MRProgressOverlayView()
    public var ExtraWebscript = Bool()
    var ProgressTimer = Timer()
    var progressRate = 0.0
    var theBool = false
 
   // @IBOutlet weak var progressView: UIProgressView!

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        webview.scrollView.bounces = false
      
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        self.navigationItem.leftBarButtonItem = backButton
        
       
        
//        let gif = UIImage(gifName: "loadinggif1")
//        let gifManager = SwiftyGifManager(memoryLimit:100)
//
//        let imageview = UIImageView(gifImage: gif, manager: gifManager)
//        imageview.image = UIImage.sd_animatedGIFNamed("loadinggif")
//        imageview.isAnimatingGif()
//        imageview.animationDuration = 5
//        imageview.startAnimating()
//
//        imageview.backgroundColor = UIColor.lightGray
//        imageview.frame = CGRect(x: 0.0, y: 5.0, width: 300.0, height: 350.0)
//        webview.addSubview(imageview)
//
        
//        let url = Bundle.main.url(forResource: "coomingsoongif", withExtension: "gif")!
//        let data = try! Data(contentsOf: url)
//        webview.load(data, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
        
//        let imageview1 = UIImageView.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 200))
//        let image1 = UIImage.sd_animatedGIFNamed("loadinggif")
//        imageview1.image = image1
//        self.view.addSubview(imageview1)
        // self.imageView2.image = UIImage.sd_animatedGIFNamed("coomingsoongif")
    //self.gifimageview.image = UIImage.sd_animatedGIFNamed("coomingsoongif")
       // SVProgressHUD.show(UIImage.init(named: "airport_services"), status: "")
        
        // Do any additional setup after loading the view.
    }
    
    func BackButtonmethod() {
        if webview.canGoBack {
            webview.goBack()
        }
        else {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        SVProgressHUD.showProgress(Float(progressRate))
//        SVProgressHUD.setRingNoTextRadius(40)
//        SVProgressHUD.setForegroundColor(UIColor.blue)

        
       let url = URL (string: self.URLString)
        let requestObj = NSURLRequest.init(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15)
     //   var requestObj = URLRequest(url: url!)
//        requestObj.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad
//        requestObj.timeoutInterval = 15
     //   webview.loadRequest(requestObj)
        self.webview.loadRequest(requestObj as URLRequest)
      
        self.navigationItem.title = NavigationTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        
        let rightbarbutton = UIBarButtonItem.init(image: UIImage.init(named: "home"), style: .done, target: self, action: #selector(HomeButton))
        self.navigationItem.rightBarButtonItem = rightbarbutton
       
        
         //  MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
//             overlay = MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
//               overlay.mode = .indeterminate
//                overlay.backgroundColor = UIColor.groupTableViewBackground
//                overlay.tintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
//                overlay.titleLabelText = "Loading"
              //  overlay.show(true)
      //  ProgressTimer.invalidate()
       
       
        
        //35 42 55
    }
    
    func HomeButton() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        SVProgressHUD.dismiss()
        self.progressRate = 0
        self.theBool = false
        SVProgressHUD.setRingNoTextRadius(24)
        SVProgressHUD.setRingThickness(2)
        progressRate = 0
        self.webview.stopLoading()
        
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
      //  progressRate = 0
        webview.isHidden = true
       
        ProgressTimer.invalidate()
        
        self.ProgressTimer = Timer.init(timeInterval: 0.3, target: self, selector: #selector(handleProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(ProgressTimer, forMode: .commonModes)
        self.theBool = false
        self.ProgressTimer.fire()
        DispatchQueue.main.async() {
            SVProgressHUD.showProgress(Float(self.progressRate))
            SVProgressHUD.setRingThickness(4)
            SVProgressHUD.setRingNoTextRadius(40)
            SVProgressHUD.setForegroundColor(UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1))
            
           
            if self.progressRate == 1 {
                SVProgressHUD.dismiss()
            }
        }
        
        
        
     
    }
    
   
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
 
        return true
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        SVProgressHUD.showError(withStatus: "Error in Fetching data, Please Try again")
        ProgressTimer.invalidate()
        progressRate = 0
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        theBool = true
        progressRate = 0
    
        
      //  webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " + "var head = document.getElementsByTagName('header').remove();" + "var set = document.getElementsByClassName('innerbodypanel');" + "set[0].style.margin = '0px';" + "var set = document.getElementsByClassName('innerbodypanel');" + "set[0].style.margin = '0px';" + "var head = document.getElementsByTagName('header')[0];" + "head.parentNode.removeChild(head);" + "head.style.margin = '0px';" + "var nav = document.getElementsByTagName('nav')[0];" + "nav.parentNode.removeChild(nav);" + "nav.style.margin = '0px';" + "var set = document.getElementsByClassName('banner');" + "set[0].style.margin = '0px';"  + "})()")
        
        if ExtraWebscript {
            webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
                "var head = document.getElementsByTagName('header').remove(); + ()")
            
            
            webview.stringByEvaluatingJavaScript(from: "javascript:(function() { " +
                "var set = document.getElementsByClassName('innerbodypanel');"
                + "set[0].style.margin = '0px';" + "var footer = document.getElementsByTagName('footer')[0];"
                + "footer.parentNode.removeChild(footer);" + "footer.style.margin = '0px';" +
                "})()")
        }
        
        


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

        
        
     //  overlay.setProgress(100, animated: true)

        
        
        
        
  
        
       // self.progressView.setProgress(1.0, animated: true)
        
       
        
       ProgressTimer.invalidate()
        
      //  overlay.dismiss(true)
       
        
        webview.isHidden = false
        SVProgressHUD.dismiss()
   
       
    }
    func handleProgress () {
        print("Progress view progress is \(progressRate)")
        if (theBool){
            if (progressRate >= 1) {
                SVProgressHUD.showProgress(Float(progressRate))
                SVProgressHUD.dismiss(withDelay: 0.2)
                ProgressTimer.invalidate()
                
            } else {
                progressRate += 0.1
                 SVProgressHUD.showProgress(Float(progressRate))
            }
        } else {
        //    progressRate += 0.01
             DispatchQueue.main.async() {
                SVProgressHUD.showProgress(Float(self.progressRate))
            }
          //  overlay.setProgress(Float(self.progressRate), animated: true)
            if (progressRate < 0.90) {
                progressRate += 0.01
              //
            }
            
            else if (progressRate < 0.99) {
                progressRate += 0.005
               // SVProgressHUD.showProgress(Float(progressRate))
            }
            else if (progressRate >= 0.99) {
                progressRate = 0.99
               // SVProgressHUD.showProgress(Float(progressRate))
            }
        }
       
       
     //   SVProgressHUD.setRingNoTextRadius(60)
        
       
        
       //
    }

  
}
