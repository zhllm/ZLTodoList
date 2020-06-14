//
//  HttpDatas.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
 // 请求框架
import Alamofire

private let httpSharedInstance = HttpDatas()

enum MethodType {
    case get
    case post
}

class HttpDatas: NSObject {
    class var sharedInstance: HttpDatas{
        return httpSharedInstance
    }
}

extension HttpDatas{
    
    /// 网络请求
    /// - Parameters:
    ///   - type: 请求方式 get / post
    ///   - URLString: 接口路径
    ///   - paramasters: 请求参数
    ///   - finishCallBack: 成功的回调
    /// - Returns: nil
    func requstDatas(_ type: MethodType, URLString: String, paramasters: [String: Any]?, finishCallBack: @escaping (_ response: Any) -> ()) {
        /// 获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        /// 发送网络请求
        Alamofire.request(URLString, method: method, parameters: paramasters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            /// 发生错误，处理错误并退出，不再继续向下执行
            guard response.result.value != nil else {
                print(response.result.error!)
                return
            }
            
            /// 获取结果
            guard response.result.isSuccess else{
                return
            }
            
            if let value = response.result.value {
                finishCallBack(value)
            }
        }
        
    }
}
