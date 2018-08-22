//
//  LCEChooseDateView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/13.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

protocol LCEChooseDateViewDelegate {
    func chooseDateAndTime(dateTime: String) -> Void
}

class LCEChooseDateView: UIView {
    
    var delegate: LCEChooseDateViewDelegate?
    open var dateTimeStr: String! {
        didSet {
            let dateFmatter = DateFormatter()
            dateFmatter.dateFormat = "yyyy年MM月dd日"
            let date = dateFmatter.date(from: String(dateTimeStr.prefix(11)))
            dateFmatter.dateFormat = "HH:mm"
            let time = dateFmatter.date(from: String(dateTimeStr.suffix(5)))
            self.datePicker.setDate(date!, animated: true)
            self.timePicker.setDate(time!, animated: true)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() -> Void {
        self.addSubview(self.dateAndTimeBgView)
        self.addSubview(self.datePicker)
        self.addSubview(self.timePicker)
    }
    
    override func updateConstraints() {
        
        self.dateButton.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.left.equalTo(0)
            make.bottom.equalTo(-1)
            make.right.equalTo(self.timeButton.snp.left)
            make.width.equalTo(self.timeButton.snp.width)
        }
        self.timeButton.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.right.equalTo(0)
            make.bottom.equalTo(-1)
            make.left.equalTo(self.dateButton.snp.right)
            make.width.equalTo(self.dateButton.snp.width)
        }
        self.datePicker.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(220)
            make.bottom.equalTo(-10)
        }
        self.timePicker.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(220)
            make.bottom.equalTo(-10)
        }
        
        super .updateConstraints()
    }
    
    // MARK: 执⌇行⌇方⌇法⌇
    @objc func touchDateButtonAction(sender: UIButton) -> Void {
        sender.isSelected = true
        self.timeButton.isSelected = false
        self.datePicker.isHidden = false
        self.timePicker.isHidden = true
    }
    @objc func touchTimeButtonAction(sender: UIButton) -> Void {
        sender.isSelected = true
        self.dateButton.isSelected = false
        self.datePicker.isHidden = true
        self.timePicker.isHidden = false
    }
    @objc func datePickerValueChange(_ datePicker: UIDatePicker) -> Void {
        let  chooseDate = datePicker.date
        let  dateFormater = DateFormatter.init()
        if self.dateButton.isSelected {
            dateFormater.dateFormat = "YYYY年MM月dd日"
            let dateStr = dateFormater.string(from: chooseDate)
            self.dateTimeStr = dateStr + self.dateTimeStr.suffix(6)
        }else {
            dateFormater.dateFormat = "HH:mm"
            let timeStr = dateFormater.string(from: chooseDate)
            self.dateTimeStr = self.dateTimeStr.prefix(11) + timeStr
        }
        self.delegate?.chooseDateAndTime(dateTime: self.dateTimeStr)
    }
    
    // 日期按钮
    lazy var dateButton : UIButton = {
        let dateButton = UIButton()
        dateButton.setTitle("日期", for: .normal)
        dateButton.setTitleColor(UIColor.orange, for: .selected)
        dateButton.setTitleColor(UIColor.black, for: .normal)
        dateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        dateButton.titleLabel?.textAlignment = .center
        dateButton.isSelected = true
        dateButton.addTarget(self, action: #selector(touchDateButtonAction(sender:)), for: .touchUpInside)
        return dateButton
    }()
    // 时间按钮
    lazy var timeButton : UIButton = {
        let timeButton = UIButton()
        timeButton.setTitle("时间", for: .normal)
        timeButton.setTitleColor(UIColor.orange, for: .selected)
        timeButton.setTitleColor(UIColor.black, for: .normal)
        timeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        timeButton.titleLabel?.textAlignment = .center
        timeButton.addTarget(self, action: #selector(touchTimeButtonAction(sender:)), for: .touchUpInside)
        return timeButton
    }()
    // 日期和时间bgView
    lazy var dateAndTimeBgView: UIView = {
        let dateAndTimeBgView = UIView()
        dateAndTimeBgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 62)
        let topLine = UIView()
        topLine.backgroundColor = UIColor.colorWithAlphaHex(0xC9CACF, alpha: 1.0)
        topLine.frame = CGRect(x: 0, y: 0, width:self.frame.size.width, height:0.5)
        let middleLine = UIView()
        middleLine.backgroundColor = UIColor.colorWithAlphaHex(0xC9CACF, alpha: 1.0)
        middleLine.frame = CGRect(x: 0, y: 0, width: 0.5, height: dateAndTimeBgView.frame.size.height)
        middleLine.center = dateAndTimeBgView.center
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.colorWithAlphaHex(0xC9CACF, alpha: 1.0)
        bottomLine.frame = CGRect(x: 0, y: dateAndTimeBgView.frame.size.height - 0.5, width:self.frame.size.width, height:0.5)
        dateAndTimeBgView.addSubview(topLine)
        dateAndTimeBgView.addSubview(middleLine)
        dateAndTimeBgView.addSubview(bottomLine)
        dateAndTimeBgView.addSubview(self.dateButton)
        dateAndTimeBgView.addSubview(self.timeButton)
        return dateAndTimeBgView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker.init()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.addTarget(self, action: #selector(datePickerValueChange(_:)), for: .valueChanged)
        return datePicker
    }()
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker.init()
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "en_GB")
        timePicker.addTarget(self, action: #selector(datePickerValueChange(_:)), for: .valueChanged)
        timePicker.isHidden = true
        return timePicker
    }()
    
}
