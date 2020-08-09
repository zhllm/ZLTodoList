//
//  UIImageExtension.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/26.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

extension UIImage {
    class func autoLoadImageFromResource(withname: String) -> UIImage {
        var pathName = ""
        if kIsIphoneX {
            pathName = "图片资源/\(withname)@3x"
        } else {
            pathName = "图片资源/\(withname)@2x"
        }
        var image: UIImage?
        if let path = Bundle.main.path(forResource: pathName, ofType: "png") {
            if let img = UIImage(contentsOfFile: String(describing: path)) {
                image = img
            }
        }
        if image == nil {
            image = UIImage(named: "logo")!
        }
        return image!
    }
}
