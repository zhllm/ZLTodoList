//
//  RoundUIButton.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class RoundUIButton: UIButton {
    
    init(title: String, borderWidth: CGFloat?, textColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        
        self.titleLabel?.font = UIFont.customFont(customType: .Montserrat, ofSize: 18)
        if borderWidth != nil {
            self.layer.borderWidth = borderWidth!
            self.layer.borderColor = UIColor.red.cgColor
        }
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
//        self.setTitleShadowColor(UIColor.cyan, for: .normal)
//        self.setTitleShadowColor(UIColor.green, for: .highlighted)
//        self.setTitleShadowColor(UIColor.brown, for: .disabled)
//        self.setTitleShadowColor(UIColor.darkGray, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
