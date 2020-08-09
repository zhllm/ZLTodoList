//
//  protocols.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

enum SignupState {
    case signedUp(signedUp: Bool)
}

protocol GithubAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    
    func signup(_ username: String, password: String) -> Observable<Bool>
}

protocol GithubValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatePassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

extension ValidationResult {
    var isVaild: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
