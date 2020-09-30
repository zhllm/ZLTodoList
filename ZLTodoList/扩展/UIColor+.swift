//
//  UIColor+.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/10.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat , _ b: CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(_ r: CGFloat, _ g: CGFloat , _ b: CGFloat, _ a: CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
}
