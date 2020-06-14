//
//  RoundUIButton.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class RoundUIButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .normal)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        
        self.setTitleShadowColor(UIColor.cyan, for: .normal)
        self.setTitleShadowColor(UIColor.green, for: .highlighted)
        self.setTitleShadowColor(UIColor.brown, for: .disabled)
        self.setTitleShadowColor(UIColor.darkGray, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
