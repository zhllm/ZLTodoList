//
//  CollectionReusableView.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/12.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        titleLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
