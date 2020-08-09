//
//  BindingExtensions.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit


extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating....."
        case let .failed(message):
            return message
        }
    }
}

struct ValidateColors {
    static let okColor = UIColor(red: 138.0 / 250, green: 221.0 / 250, blue: 109.0 / 250, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidateColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return .black
        case .failed:
            return ValidateColors.errorColor
        }
    }
}


extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { (label, reslut) in
            label.textColor = reslut.textColor
            label.text = reslut.description
        }
    }
}

