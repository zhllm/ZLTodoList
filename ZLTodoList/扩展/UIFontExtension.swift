//
//  UIFontExtension.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/17.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

enum CustomFontType: String {
    case Avenir = "Avenir"
    case Montserrat = "Montserrat"
    case iconfont = "iconfont"
}

let widthScale = kScreenW / 375

extension UIFont {
    static func iconFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "IconFont", size: fontSize)!
    }
    
    static func customFont(customType ofType: CustomFontType, ofSize fontsize: CGFloat) -> UIFont {
        let fType = ofType.rawValue
        return UIFont(name: fType, size: fontsize * widthScale)!
    }
}
