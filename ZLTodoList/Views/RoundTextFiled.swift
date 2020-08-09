//
//  RoundTextFiled.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/12.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class RoundTextFiled: UITextField {
    init(placeholder: String, isPass: Bool){
        super.init(frame: .zero)
        // self.borderStyle = .roundedRect
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        // self.layer.borderWidth = 2.0
        // self.layer.borderColor = UIColor.blue.cgColor
        self.placeholder = placeholder
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 14.0
        self.clearButtonMode = .whileEditing
        self.isSecureTextEntry = isPass
        self.backgroundColor =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
