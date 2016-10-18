//
//  DetailFlowLayout.swift
//  网易新闻详情页
//
//  Created by 123 on 16/10/1.
//  Copyright © 2016年 叶建华. All rights reserved.
//

import UIKit

class DetailFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        itemSize = CGSize(width: kScreenWidth, height: kScreenHeight * 0.9)
        scrollDirection = .horizontal
        minimumLineSpacing = kCommonMargin
        collectionView?.isPagingEnabled = true
    }
    
}
