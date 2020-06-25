//
//  ZLWXViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import MJRefresh

class ZLWXViewController: UIViewController {

    private let usualFeatures = [
        (name: "转账", icon: ""),
        (name: "信用卡还款", icon: ""),
        (name: "余额宝", icon: ""),
        (name: "生活缴费", icon: ""),
        (name: "我的快递", icon: ""),
        (name: "天猫", icon: ""),
        (name: "AA收款", icon: ""),
        (name: "上银汇款", icon: ""),
        (name: "爱心捐赠", icon: ""),
        (name: "彩票", icon: ""),
        (name: "游戏中心", icon: ""),
        (name: "更多", icon: "")
    ]
    
    private lazy var collectionViewHeight: CGFloat = {
        let itemWidth = (kScreenW - 180) / 4
        return (itemWidth + 20) * 3 + 160
    }()
    
    
    private lazy var scrollView: UIScrollView = {UIScrollView()}()
    
    private lazy var collectionView: UICollectionView = {
        let itemWidth = (kScreenW - 180) / 4
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 40
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: collectionViewHeight)
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        // 在垂直方向上 滚动到达底部或顶部是否有反弹效果
        collection.alwaysBounceVertical = true
        // 隐藏竖直方向上的滚动条
        collection.showsVerticalScrollIndicator = false
        collection.register(ZLCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    private lazy var mjHeader = { MJRefreshHeader() }()
    private lazy var mjFooter = { MJRefreshAutoFooter() }()
    
    private lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - kNavgationBarH)
        let table = UITableView(frame: frame, style: .plain)
        table.dataSource = self
        table.contentInset = UIEdgeInsets(top: collectionViewHeight, left: 0, bottom: 49, right: 0)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.scrollIndicatorInsets = UIEdgeInsets(top: collectionViewHeight, left: 0, bottom: 0, right: 0)
        mjHeader.setRefreshingTarget(self, refreshingAction: #selector(refresh))
        table.mj_header = mjHeader
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        table.mj_footer = mjFooter
        return table
    }()
    
    @objc func refresh() {
        self.tableView.mj_header?.endRefreshing()
    }
    
     var index = 0
    @objc func footerRefresh(){
        self.tableView.mj_footer!.endRefreshing()
        // 2次后模拟没有更多数据
        index = index + 1
        if index > 2 {
            mjFooter.endRefreshingWithNoMoreData()
        }
    }
    
    private lazy var headerView: ZLHeaderViews = {
        let header = ZLHeaderViews()
        
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        disableAdjustsScrollViewInsets(scrollView)
        disableAdjustsScrollViewInsets(tableView)
        disableAdjustsScrollViewInsets(collectionView)
        
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        addSubviews()
    }
    
    
    func addSubviews() {
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(kNavgationBarH)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(tableView)
        scrollView.addSubview(collectionView)
        
        // 禁止中间的collectionView滚动
        collectionView.isScrollEnabled = false
        
        scrollView.gestureRecognizers?.forEach({ (gesture) in
            scrollView.removeGestureRecognizer(gesture)
        })
        
        tableView.gestureRecognizers?.forEach({ (gesture) in
            scrollView.addGestureRecognizer(gesture)
        })
    }
    
    private func updateNavigationItem(_ flag: Bool) {
        if flag {
            navigationItem.leftBarButtonItems = ["", "", "", ""].map{
                let bar = UIBarButtonItem(title: $0, style: .plain, target: nil, action: nil)
//                bar.setTitleTextAttributes(<#T##attributes: [NSAttributedString.Key : Any]?##[NSAttributedString.Key : Any]?#>, for: <#T##UIControl.State#>)
                return bar
            }
        }
    }

}

// MARK: UICollectionViewDataSource
extension ZLWXViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usualFeatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZLCollectionViewCell
        cell.setupUsaulFeatureInfo(info: usualFeatures[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        header.addSubview(headerView)
        
        return header
    }
    
}


extension ZLWXViewController: UICollectionViewDelegate{
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ZLWXViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 80)
    }
}

extension ZLWXViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "row \(indexPath.row)"
        return cell!
    }
}

extension ZLWXViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let originY = tableView.contentOffset.y + collectionViewHeight
            print("\(tableView.contentOffset.y):\(collectionViewHeight):\(originY)")
            if originY > 0 {
                // 中间的collectionView随着tableView滚动
                collectionView.frame.origin.y = -originY
                
                // 导航栏渐变效果
                let height = headerView.bounds.height / 2
                headerView.contentView.alpha = 1 - originY / headerView.bounds.height
                if originY < height {
                    let alpha = originY / height
                    // searchTextField.alpha = 1 - alpha
                    updateNavigationItem(false)
                }
                else {
                    updateNavigationItem(true)
//                    let alpha =  (originY - height) / height
//                    navigation.item.leftBarButtonItems?.forEach {
//                        $0.tintColor = UIColor.white.withAlphaComponent(alpha)
//                    }
                }
            }
            else {
                collectionView.frame.origin.y = 0
                headerView.contentView.alpha = 1
//                searchTextField.alpha = 1
//                navigation.item.rightBarButtonItems?.forEach { $0.tintColor = UIColor.white }
            }
        }
    }
}
