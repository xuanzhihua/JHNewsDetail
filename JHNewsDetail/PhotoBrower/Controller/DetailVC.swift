//
//  DetailVC.swift
//  网易新闻详情页
//
//  Created by 123 on 16/10/1.
//  Copyright © 2016年 叶建华. All rights reserved.
//

import UIKit

private let cellID = "detail"

class DetailVC: UIViewController {

    var currentIndexPath: IndexPath {
        get {
            return collectionView.indexPathsForVisibleItems.first!
        }
    }
    
    
    lazy var collectionView: UICollectionView = {
       
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth + kCommonMargin, height: kScreenHeight * 0.9)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: DetailFlowLayout())
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        return collectionView
        
    }()
    
    /// 记录数据源
    var listMs: [JHImgModel] = [JHImgModel]()

    /// 记录需要滚动的行号
    var scrollToRow: Int = 0
    
}

// 主要的业务逻辑
extension DetailVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 注册cell
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        
        let indexPath = IndexPath(row: scrollToRow, section: 0)
        
        // atScrollPosition: cell与collectionView的对齐方式
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
    }
    
    /**
     关闭方法
     */
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        
        let cell = collectionView.cellForItem(at: currentIndexPath) as! DetailCell
        let image = cell.imageView.image
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
    }
    
}


// MARK: - 数据源方法
extension DetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailCell
        cell.listM = listMs[(indexPath as NSIndexPath).row]
        return cell
    }
}


