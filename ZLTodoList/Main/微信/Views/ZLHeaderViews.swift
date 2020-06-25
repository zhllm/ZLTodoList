//
//  ZLHeaderViews.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/17.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class ZLHeaderViews: UIView {
    var contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 80))
        self.backgroundColor = .global
        addsubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addsubviews() {
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let features = [(name: "扫一扫", icon: ""),
                        (name: "付钱", icon: ""),
                        (name: "收钱", icon: ""),
                        (name: "账单", icon: ""),]
        let itemWidth = kScreenW / 4
        
        for (index, feature) in features.enumerated() {
            let btn = UIButton(type: .system)
            btn.setTitle(feature.icon, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.iconFont(ofSize: 32)
            btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
            self.contentView.addSubview(btn)
            
            let label = UILabel()
            label.text = feature.name
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
            contentView.addSubview(label)
            
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(itemWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: itemWidth, height: 50.0))
            }
            
            label.snp.makeConstraints { (make) in
                make.centerX.equalTo(btn.snp.centerX)
                make.top.equalTo(btn.snp.bottom)
            }
            
        }
    }
    
    @objc func btnAction(_ sender: UIButton) {
        print("click")
    }
    

}
