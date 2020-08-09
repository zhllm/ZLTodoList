//
//  ContentScrollView.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/1.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class ContentScrollView: UIViewController {

    var childCanScroll = false
    
    var parentCanScroll: Bool!
    
    var superCanScrollBlock: ((Bool) -> Void)?
    
    public lazy var contentView: UIScrollView = {
        let scrollView =  UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(contentView)
        contentView.delegate = self
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        contentView.contentSize = CGSize(width: 0, height: 2000)
    }
    
}

extension ContentScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !childCanScroll {
            scrollView.contentOffset = .zero
        } else {
            if scrollView.contentOffset.y <= 0 {
                scrollView.contentOffset = .zero
                superCanScrollBlock?(true)
            }
        }
        scrollView.showsVerticalScrollIndicator = !parentCanScroll
    }
}
