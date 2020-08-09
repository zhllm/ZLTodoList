//
//  ZLContactViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

public enum homeError {
    case internetError(String)
    case serverMessage(String)
}

class Model: NSObject {
    var id: Int
    var sn: String
    required  init(id: Int, sn: String) {
        self.id = id
        self.sn = sn
        super.init()
    }
}

class ZLContactViewController: UIViewController {
    private lazy var userName: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 6
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 2
        field.layer.masksToBounds = true
        return field
    }()
    
    private lazy var password: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 6
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 2
        field.layer.masksToBounds = true
        return field
    }()
    
    private lazy var counts: UILabel = {
        let textLabel =  UILabel()
        textLabel.font = UIFont.customFont(customType: .Montserrat, ofSize: 24)
        textLabel.text = "当前字数"
        return textLabel
    }()
    
    private lazy var label: UILabel = {
        let textLabel =  UILabel()
        textLabel.font = UIFont.customFont(customType: .Montserrat, ofSize: 24)
        return textLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "提交"
        button.setTitle("提交", for: .normal)
        return button
    }()
    
    func bind() {
        let dispose = DisposeBag()
        let observable = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler())
        //        observable.map {
        //            return "当前索引数：\($0 )"
        //        }.bind { [weak self] (text) in
        //            self?.label.text = text
        //        }.disposed(by: dispose)
        observable
            .map {
                return "当前索引数：\($0 )"
        }
        .bind { [weak self](text) in
            print(text)
            //收到发出的索引数后显示到label上
            self?.label.text = text
        }
        .disposed(by: dispose)
        
        
        let _ = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler())
            .subscribe(onNext: { print($0, terminator: " ") })
            .disposed(by: dispose)
    }
    
    func test() {
        let observer: Binder<String> = Binder(label) { view, text in
            view.text = text
        }
        
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        observable.map{ "\($0)" }.bind(to: observer).disposed(by: dispose)
        
        let neverSequence = Observable<String>.never()
        _ = neverSequence.subscribe { _ in
            print("This will never print anything")
        }.addDisposableTo(dispose)
        
        Observable<String>.empty().subscribe{
            event in
            print("empty \(event)")
        }.disposed(by: dispose)
        
        Observable.generate(
            initialState: 2,
            condition: { $0 < 3 },
            iterate: { $0 + 1 }
        )
            .subscribe(onNext: { print($0) })
            .disposed(by: dispose)
        
        
        let deferredSequence = Observable<String>.deferred {
            
            return Observable.create { observer in
                print("emit")
                observer.onNext("1")
                observer.onNext("2")
                observer.onNext("3")
                return Disposables.create()
            }
        }
        
        deferredSequence.subscribe(onNext: { event in
            print(event)
        }).disposed(by: dispose)
        
        deferredSequence.subscribe(onNext: { event in
            print(event)
        }).disposed(by: dispose)
    }
    
    func test3() {
        //        self.view.addSubview(userName)
        //        userName.snp.makeConstraints { (make) in
        //            make.centerY.equalToSuperview()
        //            make.centerX.equalToSuperview()
        //            make.width.equalToSuperview().multipliedBy(0.9)
        //            make.height.equalTo(60)
        //        }
        //        userName.backgroundColor = .gray
        
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        label.text = "hello world"
        label.textColor = .black
        //        let observer: AnyObserver<String> = AnyObserver{ [weak self] (event) in
        //            print(1231)
        //            switch event {
        //            case .next(let text):
        //                self?.label.text = text
        //            default:
        //                break
        //            }
        //        }
        //
        //        let observabel = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        //        observabel.map{ "\($0)" }.bind(to: observer).disposed(by: dispose)
        
        
        
        //        let observer = AnyObserver<String> { [weak self] event in
        //            switch event {
        //            case .next(let text):
        //                self?.label.text = text
        //            default:
        //                break
        //            }
        //        }
        //
        //        let observabel = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        //
        //        observabel.map { "已执行 \($0)" }.bind(to: observer).disposed(by: dispose)
    }
    
    private lazy var leftView = { UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 2)) }()

    let dispose = DisposeBag()
    
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var models = [
            Model(id: 1, sn: "1"),
            Model(id: 2, sn: "2"),
            Model(id: 3, sn: "3"),
            Model(id: 4, sn: "4"),
            Model(id: 5, sn: "5"),
            Model(id: 6, sn: "6"),
            Model(id: 7, sn: "7"),
        ]
        
        
        
        let ob = Observable.of(models)
        
        
        ob.subscribe(onNext: { val in
            for (index, val) in val.enumerated() {
                print(val.id)
            }
        }).disposed(by: dispose)
        
        models[2].id = 5
        models.append(Model(id: 8, sn: "8"))
        self.view.addSubview(userName)
        self.view.addSubview(password)
        self.view.addSubview(counts)
        self.view.addSubview(button)
        userName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(160)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(48)
            make.left.right.height.equalTo(userName)
        }
        
        counts.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(48)
            make.left.right.height.equalTo(password)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(counts.snp.bottom).offset(48)
            make.left.right.height.equalTo(password)
        }
        button.setTitle("提交", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 6
        button.isUserInteractionEnabled = true
        
        let input = userName.rx.text.orEmpty.asDriver().throttle(0.3)
        
        
        input.drive(password.rx.text).disposed(by: dispose)
        
        input.map { "当前字数\($0.count)" }.drive(counts.rx.text).disposed(by: dispose)
        
        // input.map { $0.count > 5 }.drive(button.rx.isEnabled).disposed(by: dispose)
        
        // textFiled.resignFirstResponder()
//        let gesture = UIGestureRecognizer(target: self, action: #selector(closeKeyborad))
//        self.view.addGestureRecognizer(gesture)
        
        
        let controlEvent1 = button.rx.controlEvent(.touchUpInside)
        let controlEvent2 = button.rx.tap
        
        controlEvent1.subscribe { (result) in
            print("1: \(result) \(Thread.current)")
        }.disposed(by: dispose)

        controlEvent2.subscribe { (result) in
            print("1: \(result) \(Thread.current)")
        }.disposed(by: dispose)

        controlEvent1.subscribe { (result) in
            print("2: \(result) \(Thread.current)")
        }.disposed(by: dispose)
        
    }
    
    @objc func click(_ sender: UIButton) {
        print(123123)
    }
    
    @objc func closeKeyborad() {
        userName.resignFirstResponder()
    }
}


