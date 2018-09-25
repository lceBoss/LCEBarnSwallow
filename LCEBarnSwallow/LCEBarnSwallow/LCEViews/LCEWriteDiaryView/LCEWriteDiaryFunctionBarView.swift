//
//  LCEWriteDiaryFunctionBarView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

// 功能bar类型
enum functionBarType {
    case date
    case icon
    case photo
    case record
}

protocol LCEWriteDiaryFunctionBarViewDelegate {
    func selectFunctionBar(type: functionBarType) -> Void
}

class LCEWriteDiaryFunctionBarView: UIView {
    
    var delegate: LCEWriteDiaryFunctionBarViewDelegate?
    
    open var dateTime: String! {
        didSet {
            let index5 = dateTime.index(dateTime.startIndex, offsetBy: 5)
            let index8 = dateTime.index(dateTime.startIndex, offsetBy: 8)
            let index10 = dateTime.index(dateTime.startIndex, offsetBy: 10)
            let year = dateTime.prefix(4)
            let month = dateTime[index5..<index8]
            let day = dateTime[index8..<index10]
            let time = dateTime.suffix(5)
            let date = year + "-" + month.prefix(2) + "-" + day
            let week = getWeekDay(dateStr: date)
            self.monthLabel.text = String(month) as String
            self.dayLabel.text = String(day) as String
            self.weekAndMomentLabel.text = week + " " + time
        }
    }
    
    open var iconDic: Dictionary<String, String>! {
        didSet {
            let weatherIndex: Int = Int(iconDic["weather"]!)!
            let kindIndex: Int = Int(iconDic["kind"]!)!
            let paperArr = ["one", "two", "three", "four", "five", "six", "women_face", "man_face"]
            let paperValue: String = iconDic["paper"]!
            let index = paperValue.index(of: "-")
            let paperSection: Int = Int(paperValue.prefix(upTo: index!))!
            let paperIndex: Int = Int(paperValue.suffix(from: index!))!
            self.weatherImageView.image = UIImage.init(named: "look_weather\(weatherIndex + 1)")
            self.moodImageView.image = UIImage.init(named: "diary_face\(kindIndex + 1)")
            if paperSection < 9 {
                self.iconImageView.image = UIImage.init(named: "\(paperArr[paperSection])\(-paperIndex + 1)")
            }
        }
    }
    
    // 获取星期根据日期
    func getWeekDay(dateStr:String) ->String {
        let dateArr = dateStr.components(separatedBy:"-")
        if dateArr.count == 3 {
            var y = Int(dateArr[0])!
            var m = Int(dateArr[1])!
            let d = Int(dateArr[2])!
            if m == 1 || m == 2 {
                m += 12
                y -= 1
            }
            let iWeek = (d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7
            
            switch iWeek {
            case 0: return "星期一"
            case 1: return "星期二"
            case 2: return "星期三"
            case 3: return "星期四"
            case 4: return "星期五"
            case 5: return "星期六"
            case 6: return "星期天"
            default:
                return ""
            }
        }else {
            return "星期未知"
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        self.addSubview(self.bgImageView)
        self.addSubview(self.dateView)
        self.addSubview(self.iconView)
        self.addSubview(self.photoView)
        self.addSubview(self.recordView)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super .updateConstraints()
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.dateView.snp.makeConstraints { (make) in
            make.top.left.equalTo(1)
            make.bottom.equalTo(-1)
            make.size.equalTo(CGSize(width: (self.frame.size.width - 5) / 4, height: self.frame.size.height - 2))
        }
        self.dateButton.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.monthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.width.equalTo(self.dateView.snp.width)
            make.centerX.equalTo(self.dateButton.snp.centerX)
            make.height.equalTo(20)
        }
        self.dayLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.dateView.snp.centerX)
            make.centerY.equalTo(self.dateView.snp.centerY)
            make.width.equalTo(self.dateView.snp.width)
            make.height.equalTo(25)
        }
        self.weekAndMomentLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.dateButton.snp.centerX)
            make.width.equalTo(self.dateView.snp.width)
            make.height.equalTo(18)
            make.bottom.equalTo(self.dateView.snp.bottom).offset(-5)
        }
        
        self.iconView.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.left.equalTo(self.dateView.snp.right).offset(1)
            make.size.equalTo(self.dateView.snp.size)
        }
        self.iconButton.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.weatherImageView.snp.makeConstraints { (make) in
            make.top.equalTo(2)
            make.centerX.equalTo(self.iconButton.snp.centerX)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        self.moodImageView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        self.iconImageView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-1.5)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        self.photoView.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.size.equalTo(self.iconView.snp.size)
            make.left.equalTo(self.iconView.snp.right).offset(1)
        }
        self.photoButton.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.recordView.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.left.equalTo(self.photoView.snp.right).offset(1)
            make.size.equalTo(self.photoView.snp.size)
        }
        self.recordButton.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    // MARK: 方法
    @objc func selectDate(sender: UIButton) -> Void {
        self.delegate?.selectFunctionBar(type: .date)
    }
    @objc func selectIcon(sender: UIButton) -> Void {
        self.delegate?.selectFunctionBar(type: .icon)
    }
    @objc func selectPhoto(sender: UIButton) -> Void {
        self.delegate?.selectFunctionBar(type: .photo)
    }
    @objc func selectRecord(sender: UIButton) -> Void {
        self.delegate?.selectFunctionBar(type: .record)
    }
    // MARK: 懒加载
    // 背景图
    lazy var bgImageView : UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage.init(named: "diary_header_bg")
        return bgImageView
    }()
    // 日期
    lazy var dateView : UIView = {
        let dateView = UIView()
        dateView.addSubview(self.dateButton)
        dateView.addSubview(self.monthLabel)
        dateView.addSubview(self.dayLabel)
        dateView.addSubview(self.weekAndMomentLabel)
        return dateView
    }()
    lazy var dateButton : UIButton = {
        let dateButton = UIButton()
        dateButton.setBackgroundImage(UIImage.init(named: "diary_calendar_bg1"), for: .normal)
        dateButton.addTarget(self, action: #selector(selectDate(sender:)), for: .touchUpInside)
        return dateButton
    }()
    lazy var monthLabel : UILabel = {
        let monthLabel = UILabel()
        monthLabel.textColor = UIColor.white
        monthLabel.font = UIFont.systemFont(ofSize: 13)
        monthLabel.textAlignment = NSTextAlignment.center
        monthLabel.text = "7月"
        return monthLabel
    }()
    lazy var dayLabel : UILabel = {
        let dayLabel = UILabel()
        dayLabel.textColor = UIColor.black
        dayLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.text = "28"
        return dayLabel
    }()
    lazy var weekAndMomentLabel : UILabel = {
        let weekAndMomentLabel = UILabel()
        weekAndMomentLabel.textColor = UIColor.black
        weekAndMomentLabel.font = UIFont.systemFont(ofSize: 11)
        weekAndMomentLabel.textAlignment = NSTextAlignment.center
        weekAndMomentLabel.text = "星期五 10:42"
        return weekAndMomentLabel
    }()
    // 小图标
    lazy var iconView : UIView = {
        let iconView = UIView()
        iconView.addSubview(self.iconButton)
        iconView.addSubview(self.weatherImageView)
        iconView.addSubview(self.moodImageView)
        iconView.addSubview(self.iconImageView)
        return iconView
    }()
    lazy var iconButton : UIButton = {
        let iconButton = UIButton()
        iconButton.setBackgroundImage(UIImage.init(named: "diary_weather_bg"), for: .normal)
        iconButton.addTarget(self, action: #selector(selectIcon(sender:)), for: .touchUpInside)
        return iconButton
    }()
    lazy var weatherImageView : UIImageView = {
        let weatherImageView = UIImageView()
        return weatherImageView
    }()
    lazy var moodImageView : UIImageView = {
        let moodImageView = UIImageView()
        return moodImageView
    }()
    lazy var iconImageView : UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    // 照片
    lazy var photoView : UIView = {
        let photoView = UIView()
        photoView.addSubview(self.photoButton)
        return photoView
    }()
    lazy var photoButton : UIButton = {
        let photoButton = UIButton()
        photoButton.setBackgroundImage(UIImage.init(named: "diary_photo_bg"), for: .normal)
        photoButton.setBackgroundImage(UIImage.init(named: "diary_photo_bg_red"), for: .selected)
        photoButton.addTarget(self, action: #selector(selectPhoto(sender:)), for: .touchUpInside)
        return photoButton
    }()
    // 录音
    lazy var recordView : UIView = {
        let recordView = UIView()
        recordView.addSubview(self.recordButton)
        return recordView
    }()
    lazy var recordButton : UIButton = {
        let recordButton = UIButton()
        recordButton.setBackgroundImage(UIImage.init(named: "diary_sound_button"), for: .normal)
        recordButton.setBackgroundImage(UIImage.init(named: "diary_sound_green_button"), for: .selected)
        recordButton.addTarget(self, action: #selector(selectRecord(sender:)), for: .touchUpInside)
        return recordButton
    }()
}
