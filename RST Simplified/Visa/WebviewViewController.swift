//
//  WebviewViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 07/11/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import MRProgress

class WebviewViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webview: UIWebView!
    public var URLString = String()
    public var NavigationTitle = String()
    var overlay = MRProgressOverlayView()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        webview.scrollView.bounces = false
        
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
    
    override func viewWillAppear(_ animated: Bool) {
       let url = URL (string: self.URLString)
        let requestObj = URLRequest(url: url!)
        webview.loadRequest(requestObj)
        self.navigationItem.title = NavigationTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
        
        let rightbarbutton = UIBarButtonItem.init(image: UIImage.init(named: "home"), style: .done, target: self, action: #selector(HomeButton))
        self.navigationItem.rightBarButtonItem = rightbarbutton
       
         //  MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
             overlay = MRProgressOverlayView.showOverlayAdded(to: self.view, animated: true)
               overlay.mode = .indeterminate
                overlay.backgroundColor = UIColor.groupTableViewBackground
                overlay.tintColor = UIColor.init(red: 35.0/255.0, green: 42.0/255.0, blue: 55.0/255.0, alpha: 1)
                overlay.titleLabelText = "Loading"
              //  overlay.show(true)
        
        
        
        //35 42 55
    }
    
    func HomeButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        SVProgressHUD.dismiss()
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
        overlay.show(true)
        
        
        
        
       // SVProgressHUD.show()
     //   SVProgressHUD.showProgress(0.5, status: "Loading")
//        SVProgressHUD.setRingRadius(10)
//        SVProgressHUD.show(UIImage.sd_animatedGIFNamed("loadinggif1"), status: "Loading")

        
       
        
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
       
        
        overlay.dismiss(true)
        
        webview.isHidden = false
        //SVProgressHUD.dismiss()
       
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
