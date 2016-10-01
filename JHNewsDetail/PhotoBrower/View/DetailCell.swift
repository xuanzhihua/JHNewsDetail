//
//  DetailCell.swift
//  网易新闻详情页
//
//  Created by 123 on 16/10/1.
//  Copyright © 2016年 叶建华. All rights reserved.
//

import UIKit
import SDWebImage

class DetailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var listM: JHImgModel? {
        
        didSet {
            let url = NSURL(string: listM?.pic_url ?? "")
            imageView.contentMode = .ScaleAspectFit
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placehoder_picture"))
        }
    }

 

}
