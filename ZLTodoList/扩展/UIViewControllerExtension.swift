//
//  UIViewControllerExtension.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/17.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

extension UIViewController {
    func disableAdjustsScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}
