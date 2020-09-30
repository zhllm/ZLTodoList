//
//  CollectionViewCell.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/12.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var titleLabel = UILabel()
    
    var pictureView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 2, y: frame.size.width, width: frame.size.width - 4, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        pictureView.frame = CGRect(x: 8, y: 8, width: frame.size.width - 16, height: frame.size.width - 16)
        pictureView.contentMode = .scaleAspectFit
        contentView.addSubview(pictureView)
    }
    
    func setData(_ model: CollectionViewModel) {
        titleLabel.text = model.name
        pictureView.image = UIImage.autoLoadImageFromResource(withname: model.picture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
