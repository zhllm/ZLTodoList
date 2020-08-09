//
//  ZLWXMainViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/23.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class ZLWXMainViewController: UIViewController {

    private lazy var parentView: MainScrollVIew = { MainScrollVIew() }()
    
    private lazy var childViewVC: ContentScrollView = { ContentScrollView() }()
    
    private lazy var headerView: UIView = { UIView() }()
    
    private var parentCanScroll = true
    private var childCanScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(parentView)
        parentView.addSubview(headerView)
        parentView.addSubview(childViewVC.view)
        self.addChild(childViewVC)
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        let rect = self.view.frame.size
        
        parentView.automaticallyAdjustsScrollIndicatorInsets = false
        parentView.showsHorizontalScrollIndicator = false
        parentView.showsVerticalScrollIndicator = false
        parentView.delegate = self
        
        parentView.contentSize = CGSize(width: rect.width, height: rect.height + 200 - 64)
        parentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(64)
        }
        
        headerView.backgroundColor = .red
        headerView.frame = CGRect(x: 0, y: 0, width: rect.width, height: 200)
        
        childViewVC.view.frame = CGRect(x: 0, y: 200, width: rect.width, height: rect.height)
        childViewVC.view.backgroundColor = .yellow
        childViewVC.superCanScrollBlock = {[weak self] (canScroll) in
            self?.parentCanScroll = canScroll
        }
        childViewVC.parentCanScroll = parentCanScroll
        
    }
}

extension ZLWXMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !parentCanScroll {
            scrollView.contentOffset = CGPoint(x: 0, y: 160)
            childViewVC.childCanScroll = true
            childViewVC.parentCanScroll = parentCanScroll
        } else {
            if scrollView.contentOffset.y >= 160 {
                scrollView.contentOffset = CGPoint(x: 0, y: 160)
                childViewVC.childCanScroll = true
                parentCanScroll = false
                childViewVC.parentCanScroll = parentCanScroll
            }
        }
        scrollView.showsVerticalScrollIndicator = parentCanScroll
    }
}

extension ZLWXMainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
