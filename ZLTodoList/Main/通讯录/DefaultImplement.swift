//
//  DefaultImplement.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/5.
//  Copyright © 2020 张杰. All rights reserved.
//

import RxSwift
import RxCocoa

import Foundation.NSCharacterSet
import Foundation.NSURL
import Foundation.NSURLRequest
import Foundation.NSRange
import Foundation.NSURLSession


class GitHubDefaultValidationService: GithubValidationService {
    let API: GithubAPI
    let minPasswordCount = 5
    
    static let sharedValidationService = GitHubDefaultValidationService(API: GithubDefaultAPI.sharedAPI)
    
    init(API: GithubAPI) {
        self.API = API
    }
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return .just(.empty)
        }
        
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "Username can only contain numbers or digits"))
        }
        
        let loadingValue = ValidationResult.validating
        
        return API.usernameAvailable(username)
            .map { available in
                if available {
                    return .ok(message: "Username available")
                }
                return .failed(message: "Username already taken")
        }
        .startWith(loadingValue)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        
        return .ok(message: "Password acceptable")
    }
    
    func validateRepeatePassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "Password repeated")
        }
        else {
            return .failed(message: "Password different")
        }
    }
    
}

class GithubDefaultAPI: GithubAPI {
    
    let URLSession: Foundation.URLSession
    
    static let sharedAPI = GithubDefaultAPI(
        URLSession: Foundation.URLSession.shared
    )
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username)")!
        return Observable.of(false)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        return Observable.of(false)
    }
}
