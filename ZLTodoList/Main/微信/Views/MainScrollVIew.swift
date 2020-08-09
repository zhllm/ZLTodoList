//
//  MainScrollVIew.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/1.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class MainScrollVIew: UIScrollView, UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
