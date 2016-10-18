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
        
        let indexPath = Bundle.main.url(forResource: "index", withExtension: "html")
        let request = URLRequest(url: indexPath!)
        self.webView.loadRequest(request)
        
        self.bridge?.setWebViewDelegate(self)
        self.bridge = WebViewJavascriptBridge(for: self.webView)
        WebViewJavascriptBridge.enableLogging()
        
        self.bridge?.registerHandler("openCameraLib", handler: { (data, responseCallback) -> Void in
            
            guard let dataDic = data as? [String: AnyObject] else {
                print("data不是字典类型")
                return
            }
            guard let srcArr = dataDic["srcArr"] as? [[String: AnyObject]] else {
                print("dataDic[srcArr],取值失败,或者不是数组字典类型")
                return
            }
            var listMS = [JHImgModel]()
            for i in 0..<srcArr.count {
                let src = srcArr[i]
                let imgM = JHImgModel(dic: src)
                listMS.append(imgM)
            }
            
            
            let detailVC = DetailVC()
            self.detailVC = detailVC
            detailVC.listMs = listMS
            detailVC.scrollToRow = dataDic["index"] as! Int
            detailVC.modalPresentationStyle = .custom
            
            self.present(detailVC, animated: true, completion: nil)

        })
    }
}



// MARK: - 夜间模式 改变字体大小
extension ViewController{
    
    // 全局换肤课通过appearance统一设置，这里只处理局部
    @IBAction func changeSwState(_ sender: UISwitch) {
        if sender.isOn {
            
            sender.setOn(true, animated: true)
            self.bottomView.backgroundColor = UIColor.black
            self.leftTitle.textColor = UIColor.red
            self.rightTitle.setTitleColor(UIColor.red, for:UIControlState())
            self.navigationController?.navigationBar.barTintColor = UIColor.black
            self.navigationController?.navigationBar.backgroundColor =  UIColor.black
            self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: UIColor.red, forKey: NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject]
            isLight = true
            
        }else{
            
            sender.setOn(false, animated: true)
            self.bottomView.backgroundColor = UIColor.groupTableViewBackground
            self.leftTitle.textColor = UIColor.black
            self.rightTitle.setTitleColor(UIColor.black, for:UIControlState())
            self.navigationController?.navigationBar.barTintColor = nil
            self.navigationController?.navigationBar.backgroundColor =  UIColor.groupTableViewBackground
            self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(object: UIColor.black, forKey: NSForegroundColorAttributeName as NSCopying) as? [String : AnyObject]
             isLight = false
        }
        
        self.bridge?.callHandler("changeState", data:isLight)
    }
    
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        self.bridge?.callHandler("changeFontSize", data: sender.value)
    }
    
}


