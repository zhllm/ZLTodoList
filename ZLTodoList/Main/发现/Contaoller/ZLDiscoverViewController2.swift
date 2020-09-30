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
    
    lazy var tableViewV: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = CGRect(x: 0, y: 0, width: 80, height: UIScreen.main.bounds.height)
        tableView.rowHeight = 55
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        return tableView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        // 分组头悬停
        flowLayout.sectionHeadersPinToVisibleBounds = true
        let itemWidth = (UIScreen.main.bounds.width - 80 - 4 - 4) / 3
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 2 + 80, y: 2 + 64, width: UIScreen.main.bounds.width - 80 - 4, height: UIScreen.main.bounds.height - 64 - 4), collectionViewLayout: self.flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        return collectionView
    }()
    
    /// 左侧tableView数据
    var tableViewData = [String]()
    /// 右侧collectionView数据
    var collectionViewData = [[CollectionViewModel]]()
    
    /// 右侧collectionView当前是否正在向下滚动（即true表示手指向上滑动，查看下面内容）
    var collectionViewIsScrollDown = true
    /// 右侧collectionView垂直偏移量
    var collectionViewLastOffsetY : CGFloat = 0.0
    
    func createTable() {
        let sql = "CREATE TABLE IF NOT EXISTS User( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER \n" +
        "); \n"
        let db = SQLiteManager.shareManager().db
        if db.open() {
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("创建成功")
            } else {
                print("创建失败")
            }
        }
        db.close()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        for i in 1 ..< 15 {
            self.tableViewData.append("分类\(i)")
        }
        
        for _ in tableViewData {
            var models = [CollectionViewModel]()
            for i in 1 ..< 6 {
                models.append(CollectionViewModel(name: "型号\(i)", picture: "Image"))
            }
            self.collectionViewData.append(models);
        }
        
        view.addSubview(tableViewV)
        view.addSubview(collectionView)
        
        tableViewV.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        
    }
    
    
    
}

extension ZLDiscoverViewController2: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let model = collectionViewData[indexPath.section][indexPath.row]
        cell.setData(model)
        return cell
    }
    
    
    
    //分区头尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
     
    //返回自定义分区头
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind:
            UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CollectionReusableView",
            for: indexPath) as! CollectionReusableView
        view.titleLabel.text = tableViewData[indexPath.section]
        return view
    }
     
    //分区头即将要显示时调用
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向上滚动，那么左侧表格自动选中该分区对应的分类
        if !collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableViewV.selectRow(at: IndexPath(row: indexPath.section, section: 0),
                                    animated: true, scrollPosition: .top)
        }
    }
     
    //分区头即将要消失时调用
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String, at indexPath: IndexPath) {
        //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown
            && (collectionView.isDragging || collectionView.isDecelerating) {
            tableViewV.selectRow(at: IndexPath(row: indexPath.section + 1, section: 0),
                                animated: true, scrollPosition: .top)
        }
    }
     
    //视图滚动时触发（主要用于记录当前collectionView是向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collectionViewLastOffsetY
                < scrollView.contentOffset.y
            collectionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
  
    
}



extension ZLDiscoverViewController2: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = tableViewData[indexPath.row]
        return cell        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        collectionViewScrolToTop(section: indexPath.row, animate: true)
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
        
    }
    
    func collectionViewScrolToTop(section: Int, animate: Bool) {
        let headerRect = collectionViewHeaderFrame(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - collectionView.contentInset.top)
        collectionView.setContentOffset(topOfHeader, animated: animate)
    }
    
    func collectionViewHeaderFrame(section: Int) -> CGRect {
        let indexPaht = IndexPath(item: 0, section: section)
        let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPaht)
        guard let frameForFistCell = attributes?.frame else {
            return .zero
        }
        return frameForFistCell
        
    }
    
}


typealias CallBackVoid = () -> Void
typealias CallBackParams = (CallBackVoid) -> Void
typealias CallBackDouble = (Int, String) -> CallBackParams


extension ZLDiscoverViewController2{
    
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
    
    func tf1() {
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
