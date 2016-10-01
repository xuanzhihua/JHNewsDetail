//
//  ViewController.swift
//  网易新闻详情页
//
//  Created by 123 on 16/9/30.
//  Copyright © 2016年 叶建华. All rights reserved.
//

import UIKit
import WebViewJavascriptBridge

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var sw: UISwitch!
    @IBOutlet weak var leftTitle: UILabel!
    @IBOutlet weak var rightTitle: UIButton!
    
    var bridge: WebViewJavascriptBridge?
    var isLight = false
    weak var detailVC: DetailVC?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indexPath = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        let request = NSURLRequest(URL: indexPath!)
        self.webView.loadRequest(request)
        
        self.bridge?.setWebViewDelegate(self)
        self.bridge = WebViewJavascriptBridge(forWebView: self.webView)
        WebViewJavascriptBridge.enableLogging()
        
        self.bridge?.registerHandler("openCameraLib", handler: { (data, responseCallback) -> Void in
            let srcArr = data["srcArr"] as! [[String: AnyObject]]
            var listMS = [JHImgModel]()
            for i in 0..<srcArr.count {
                let src = srcArr[i]
                let imgM = JHImgModel(dic: src)
                listMS.append(imgM)
            }
            
            
            let detailVC = DetailVC()
            self.detailVC = detailVC
            detailVC.listMs = listMS
            detailVC.scrollToRow = data["index"] as! Int
            detailVC.modalPresentationStyle = .Custom
            
            self.presentViewController(detailVC, animated: true, completion: nil)

        })
    }
}



// MARK: - 夜间模式 改变字体大小
extension ViewController{
    
    // 全局换肤课通过appearance统一设置，这里只处理局部
    @IBAction func changeSwState(sender: UISwitch) {
        if sender.on {
            
            sender.setOn(true, animated: true)
            self.bottomView.backgroundColor = UIColor.blackColor()
            self.leftTitle.textColor = UIColor.redColor()
            self.rightTitle.setTitleColor(UIColor.redColor(), forState:.Normal)
            self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
            self.navigationController?.navigationBar.backgroundColor =  UIColor.blackColor()
            self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: UIColor.redColor(), forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
            isLight = true
            
        }else{
            
            sender.setOn(false, animated: true)
            self.bottomView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.leftTitle.textColor = UIColor.blackColor()
            self.rightTitle.setTitleColor(UIColor.blackColor(), forState:.Normal)
            self.navigationController?.navigationBar.barTintColor = nil
            self.navigationController?.navigationBar.backgroundColor =  UIColor.groupTableViewBackgroundColor()
            self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: UIColor.blackColor(), forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
             isLight = false
        }
        
        self.bridge?.callHandler("changeState", data:isLight)
    }
    
    
    @IBAction func changeFontSize(sender: UISlider) {
        self.bridge?.callHandler("changeFontSize", data: sender.value)
    }
    
}


