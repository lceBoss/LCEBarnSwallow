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
            make.right.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: 36, height: 36))
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
        weatherImageView.image = UIImage.init(named: "look_weather1")
        return weatherImageView
    }()
    lazy var moodImageView : UIImageView = {
        let moodImageView = UIImageView()
        moodImageView.image = UIImage.init(named: "diary_face1")
        return moodImageView
    }()
    lazy var iconImageView : UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage.init(named: "five7")
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
