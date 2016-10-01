//
//  JHImgModel.swift
//  网易新闻详情页
//
//  Created by 123 on 16/10/1.
//  Copyright © 2016年 叶建华. All rights reserved.
//

import Foundation

class JHImgModel: NSObject {
    // 图片的URL地址
    var pic_url: String?
    
    init(dic: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
