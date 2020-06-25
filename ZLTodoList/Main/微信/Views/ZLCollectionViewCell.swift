//
//  ZLCollectionViewCell.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/17.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class ZLCollectionViewCell: UICollectionViewCell {
    lazy var iconLabel: UILabel = {
       let label = UILabel()
        label.font = .iconFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        
        iconLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconLabel.snp.bottom).offset(5)
            make.centerX.equalTo(iconLabel.snp.centerX)
        }
        
    }
    
    func setupUsaulFeatureInfo(info: (name: String, icon: String)) {
        iconLabel.text = info.icon
        titleLabel.text = info.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
