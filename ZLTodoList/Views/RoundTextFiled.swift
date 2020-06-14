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
        self.borderStyle = .roundedRect
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 2.0
        // self.layer.borderColor = UIColor.blue.cgColor
        self.placeholder = placeholder
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 14.0
        self.clearButtonMode = .whileEditing
        self.isSecureTextEntry = isPass
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
