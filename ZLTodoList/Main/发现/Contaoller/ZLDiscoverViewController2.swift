//
//  ZLDiscoverViewController2.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import SnapKit
import AAInfographics


class ZLDiscoverViewController2: UIViewController {
    
    var tableView: UITableView!
    let dispose = DisposeBag()
    var contentView:UIView = {
        return UIView()
    }()
    
    var send: UIButton = {
        let btn = UIButton()
        btn.setTitle("发送请求", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    var cancel: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消请求", for: .normal)
        // btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    var uiSwitch: UISwitch = {
        let us = UISwitch()
        return us
    }()
    
    var segement: UISegmentedControl!
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let loading: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    let slider: UISlider = {UISlider()}()
    
    var userModel = UserViewModel()
    
    let textField: UITextField = {
        let label = UITextField()
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 4
        label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 1))
        label.leftViewMode = .always
        return label
    }()
    
    let label = UILabel()
    
    lazy var pick: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .countDownTimer
        return date
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        return formatter
    }()
    
    let btnStart: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for:.disabled)
        return btn
    }()
    
    let leftTime = BehaviorRelay(value: TimeInterval(180))
    
    let countDownStopped = BehaviorRelay(value: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let chartWidth = self.view.frame.size.width;
        let chartHeight = self.view.frame.size.height;
        let aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 0, y: 0, width: chartWidth, height: chartHeight)
        self.view.addSubview(aaChartView)
        
        let chartModel = AAChartModel()
            .chartType(.column)//图表类型
            .title("城市天气变化")//图表主标题
            .subtitle("2020年09月18日")//图表副标题
            .inverted(false)//是否翻转图形
            .yAxisTitle("摄氏度")// Y 轴标题
            .legendEnabled(true)//是否启用图表的图例(图表底部的可点击的小圆点)
            .tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
            .categories(["一月", "二月", "三月", "四月", "五月", "六月"])
            .colorsTheme(["#fe117c","#ffc069","#06caf4"])//主题颜色数组
            .series([
                AASeriesElement()
                    .name("东京")
                    .data([7.0, 6.9, 9.5, 14.5, 18.2, 21.5])
                    .toDic()!,
                AASeriesElement()
                    .name("纽约")
                    .data([0.2, 0.8, 5.7, 11.3, 17.0, 22.0])
                    .toDic()!,
                AASeriesElement()
                    .name("柏林")
                    .data([0.9, 0.6, 3.5, 8.4, 13.5, 17.0])
                    .toDic()!])
        
        // 图表视图对象调用图表模型对象,绘制最终图形
        aaChartView.aa_drawChartWithChartModel(chartModel)
        
    }
    
    
    func startTimer() {
        countDownStopped.accept(false)
        
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(countDownStopped.asObservable().filter{ $0 })
            .subscribe {event in
                self.leftTime.accept(self.leftTime.value - 1)
                if self.leftTime.value == 0 {
                    self.countDownStopped.accept(true)
                    self.leftTime.accept(180)
                }
        }.disposed(by: dispose)
    }
}

typealias CallBackVoid = () -> Void
typealias CallBackParams = (CallBackVoid) -> Void
typealias CallBackDouble = (Int, String) -> CallBackParams


extension ZLDiscoverViewController2{
    
    func test12() {
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "文本输入框",
            "开关按钮使用",
            "进度条用法",
            "文本标签的用法",
        ])
        
        items.bind(to: tableView.rx.items){ (tv, row, e) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(e)"
            return cell
        }.disposed(by: dispose)
    }
    
    func test11() {
        self.view.addSubview(pick)
        
        pick.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(400)
            make.top.equalTo(68)
            make.centerX.equalToSuperview()
        }
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(pick.snp.bottom).offset(20)
            make.width.equalTo(pick.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(btnStart)
        
        btnStart.snp.makeConstraints { (make) in
            make.width.left.equalTo(pick)
            make.height.equalTo(60)
            make.top.equalTo(pick.snp.bottom).offset(40)
        }
        
        DispatchQueue.main.async {
            _ = self.pick.rx.countDownDuration <-> self.leftTime
        }
        
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) {
            leftTimeValue, countDownStoppedValue in
            if countDownStoppedValue {
                return "开始"
            }
            return "倒计时开始,还有\(Int(leftTimeValue))"
        }.bind(to: btnStart.rx.title()).disposed(by: dispose)
        
        countDownStopped.asDriver().drive(pick.rx.isEnabled).disposed(by: dispose)
        countDownStopped.asDriver().drive(btnStart.rx.isEnabled).disposed(by: dispose)
        
        btnStart.rx.tap
            .bind{ [weak self] in
                self?.startTimer()
                print(self!.leftTime.value + 1)
        }
        .disposed(by: dispose)
    }
    
    
    func test10() {
        let swiper = UISwipeGestureRecognizer()
        swiper.direction = .up
        self.view.addGestureRecognizer(swiper)
        
        swiper.rx.event
            .subscribe(onNext: { [weak self] recognizer in
                let point = recognizer.location(in: recognizer.view)
                self?.showAlert(title: "向上滑动", message: "\(point.x) \(point.y)")
            }).disposed(by: dispose)
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(300)
        }
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .subscribe(onNext: {[weak self] _ in
                self?.textField.endEditing(true)
            }).disposed(by: dispose)
    }
    
    func showAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func test9() {
                
        self.view.addSubview(textField)
        
        self.view.addSubview(label)
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(60)
        }
        
        textField.placeholder = "set value "
        
        label.snp.makeConstraints { (make) in
            make.width.height.equalTo(textField)
            make.left.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        
        userModel.username.bind(to: textField.rx.text).disposed(by: dispose)
        textField.rx.text.orEmpty.bind(to: userModel.username).disposed(by: dispose)
        userModel.userInfo.bind(to: label.rx.text).disposed(by: dispose)
        
    }
    
    func test8() {
        self.view.addSubview(uiSwitch)
        uiSwitch.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
            make.top.equalToSuperview().offset(120)
        }
        
        self.view.addSubview(loading)
        loading.snp.makeConstraints { (make) in
            make.top.equalTo(uiSwitch.snp.top).offset(100)
            make.centerX.equalTo(uiSwitch.snp.centerX)
            make.height.width.equalTo(60)
        }
        
        uiSwitch.rx.isOn.asObservable().bind(to: loading.rx.isAnimating).disposed(by: dispose)
        
        uiSwitch.rx.isOn.asObservable().bind(to:UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: dispose)
        
        
        self.view.addSubview(slider)
        
        slider.snp.makeConstraints { (make) in
            make.top.equalTo(uiSwitch.snp.bottom).offset(200)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        slider.rx.value.asObservable()
            .subscribe(onNext: {
                print($0)
            }).disposed(by: dispose)
    }
    
    func test7() {
        let tags = ["理财", "转让", "预约"] as [Any]
        segement = UISegmentedControl(items: tags)
        segement.layer.position = CGPoint(x: self.view.bounds.size.width / 2, y: 200)
        segement.selectedSegmentIndex = 0
        self.view.addSubview(segement)
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(segement).offset(100)
            make.height.equalTo(200)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        let showImageObservebal: Observable<UIImage> = segement.rx.selectedSegmentIndex.asObservable().map {
            let images = ["fc", "gg", "index1"]
            return UIImage.autoLoadImageFromResource(withname: images[$0])
        }
        
        showImageObservebal.bind(to: imageView.rx.image).disposed(by: dispose)
    }
    func test4() {
        self.view.addSubview(uiSwitch)
        uiSwitch.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
            make.top.equalToSuperview().offset(120)
        }
        
        self.view.addSubview(cancel)
        cancel.snp.makeConstraints { (make) in
            make.left.height.equalTo(uiSwitch)
            make.width.equalTo(200)
            make.top.equalTo(uiSwitch).offset(30)
        }
        
        uiSwitch.rx.isOn
            .bind(to: cancel.rx.isEnabled)
            .disposed(by: dispose)
        
        cancel.rx.tap.asObservable().subscribe({
            print($0)
        }).disposed(by: dispose)
    }
    
    
    func test3() {
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        let data = URLSession.shared.rx.json(url: url!).map { result -> [[String:Any]] in
            if let data = result as? [String:Any],
                let channels = data["channels"] as? [[String:Any]] {
                return channels
            } else {
                return []
            }
        }
        
        data.bind(to: tableView.rx.items) { (tv, row, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row)-\(element["name"]!)"
            return cell
        }.disposed(by: dispose)
    }
    
    func test2() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.rx.data(request: request).subscribe(onNext: {
            data in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            
            // print("请求成功", json!)
        }).disposed(by: dispose)
        
        URLSession.shared.rx.json(url: url!).subscribe(onNext: {
            json in
            let data = json as! [String:Any]
            print(data)
        }).disposed(by: dispose)
    }
    
    
    func test1() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        send.rx.tap.asObservable().flatMap {
            URLSession.shared.rx.data(request: request).takeUntil(self.cancel.rx.tap)
        }.subscribe(onNext: {
            data in
            let str = String(data: data, encoding: .utf8)
            print("请求成功！返回的数据是：", str ?? "")
        }, onError: { error in
            print("请求失败！错误原因：", error)
        }).disposed(by: dispose)
    }
    
    func upd() {
        let urlString3 = "https://www.douban.com/xxxxxxxxxx/app/radio/channels"
        let url3 = URL(string: urlString3)
        let requset3 = URLRequest(url: url3!)
        URLSession.shared.rx.response(request: requset3).subscribe(onNext: {
            (response, data) in
            if 200 ..< 300 ~= response.statusCode {
                let str = String(data: data, encoding: .utf8)
                print("请求成功, ", str)
            } else {
                print("请求失败")
            }
        }).disposed(by: dispose)
        
        let urlString = "http://169.254.244.101:3000/users/list"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        URLSession.shared.rx.response(request: request).subscribe(onNext: {
            (response, data) in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("返回的数据是", str ?? "nil")
            print(response)
        }).disposed(by: dispose)
        
        let urlString2 =  "https://www.douban.com/j/app/radio/channels"
        let url2 = URL(string: urlString2)
        let requset2 = URLRequest(url: url2!)
        URLSession.shared.rx.response(request: requset2).subscribe(onNext: {
            (response, data) in
            let str = String(data: data, encoding: .utf8)
            print("返回的数据2是", str ?? "nil")
        }).disposed(by: dispose)
        
        
        
        let subject = PublishSubject<String>()
        
        subject.window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                print("subscribe \($0)")
                $0.asObservable()
                    .subscribe(onNext: {
                        print($0)
                    }).disposed(by: self?.dispose ?? DisposeBag())
            }).disposed(by: dispose)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.onNext("4")
    }
}

class TitleTaleCell: UITableViewCell {
    
    var container: UIView!
    var title: UILabel!
    var switchs: UISwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        container = UIView()
        self.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        title = UILabel()
        switchs = UISwitch()
        container.addSubview(title)
        container.addSubview(switchs)
        title.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-120)
            make.height.equalTo(20)
        }
        title.font = UIFont.systemFont(ofSize: 16)
        switchs.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    func setValueForCell(title: String, enabled: Bool) {
        self.title.text = title
        self.switchs.setOn(enabled, animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


class Switch: UITableViewCell {
    
}


struct MySection {
    var header: String
    var items: [SectionItem]
}

extension MySection: SectionModelType {
    init(original: MySection, items: [SectionItem]) {
        self = original
        self.items = items
    }
    
    typealias Item = SectionItem
}


enum SectionItem {
    case TitleImageSectionItem(title: String, image: UIImage)
    case TitleSwitchSectionItem(title: String, enabled: Bool)
}
