//
//  IndexCategory.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/23.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class IndexCategory: UIView {
    private var imageName: String!
    private var text: String!
    private lazy var leftIcon: UIImageView = {
        let image = UIImageView()
        if let path = Bundle.main.url(forResource: self.imageName, withExtension: "png") {
            if let fileContents = try? String(contentsOf: path) {
                // we loaded the file into a string!
                image.image = UIImage(contentsOfFile: fileContents)
            }
        }
        if image.image == nil {
            image.image = UIImage(named: "feature-1")
        }
        return image
    }()
    
    private lazy var rightText: UILabel = {
       let label = UILabel()
        label.font = UIFont.customFont(customType: .Avenir, ofSize: 16)
        label.numberOfLines = 0
        label.text = self.text
        label.lineBreakMode = .byClipping
        return label
    }()
    
    func layoutChildView() {
        self.addSubview(leftIcon)
        leftIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40 * kScale)
            make.height.width.equalTo(self.snp.height)
        }
        self.addSubview(rightText)
        rightText.snp.makeConstraints { (make) in
            make.left.equalTo(leftIcon.snp.right).offset(20 * kScale)
            make.right.equalTo(self.snp.right).offset(-40 * kScale)
            make.centerY.equalToSuperview()
        }
    }
    
    convenience init(image: String, text: String) {
        self.init(frame: .zero)
        imageName = image
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("hello world")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
