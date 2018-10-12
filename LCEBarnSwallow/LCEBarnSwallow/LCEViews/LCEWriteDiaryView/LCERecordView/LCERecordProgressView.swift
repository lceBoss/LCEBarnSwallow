//
//  LCERecordProgressView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/10/9.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

enum LCERecordButtonState: Int {
    case startRecord = 101
    case endRecord = 102
    case playRecord = 103
    case pauseRecord = 104
}

class LCERecordProgressView: UIView {
    
    deinit {
        timer = nil
        print("销毁")
    }
    
    var timer :Timer!
    var recordTime = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() -> Void {
        // 录音文件
        self.addSubview(remindLabel)
        self.addSubview(bgImageView)
        self.addSubview(recordTimeLabel)
        self.addSubview(deleteButton)
        // 录音进度条
        self.addSubview(trackImageView)
        self.addSubview(centerImageView)
        // 录音记录/按钮
        self.addSubview(timeLabel)
        self.addSubview(recordButton)
    }
    
    @objc func touchDeleteRecordFile(sender: UIButton) -> Void {
        if !recordButton.isSelected {
            bgImageView.image = UIImage.init(named: "add_sound_file_no")
            recordTimeLabel.text = ""
            deleteButton.isHidden = true
            // 初始化录音
            initRecord()
        }
    }
    @objc func touchRecordButtonAction(sender: UIButton) -> Void {
        switch sender.tag {
        case LCERecordButtonState.startRecord.rawValue:
            print("开始录音")
            startOrPlayRecord(isPlay: false)
        case LCERecordButtonState.endRecord.rawValue:
            print("结束录音")
            endRecordGetFile()
        case LCERecordButtonState.playRecord.rawValue:
            print("播放录音")
            startOrPlayRecord(isPlay: true)
        case LCERecordButtonState.pauseRecord.rawValue:
            print("暂停录音")
            pauseRecord()
        default:
            break
        }
    }
    
    // MARK: - 录音事件
    // 圆形进度条动画，开始录音 或者 播放录音
    func startOrPlayRecord(isPlay: Bool) -> Void {
        self.layer.addSublayer(shapeLayer)
        if isPlay {
            recordButton.isSelected = true
            recordButton.tag = LCERecordButtonState.pauseRecord.rawValue
            shapeLayer.strokeColor = UIColor.colorWithHex(0x5fbd44).cgColor
            centerImageView.image = UIImage.init(named: "play_icon_yes")
        }else {
            recordButton.isSelected = true
            recordButton.tag = LCERecordButtonState.endRecord.rawValue
            centerImageView.image = UIImage.init(named: "recode_icon_yes")
            shapeLayer.strokeColor = UIColor.colorWithHex(0xfab925).cgColor
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    // 初始化录音，删除录音文件
    func initRecord() -> Void {
        shapeLayer.strokeEnd = 0
        shapeLayer.removeFromSuperlayer()
        recordTime = 0
        timeLabel.text = "0.0"
        recordButton.setBackgroundImage(UIImage.init(named: "start_recode_button"), for: .normal)
        recordButton.setBackgroundImage(UIImage.init(named: "stop_recode_button"), for: .selected)
        recordButton.isSelected = false
        recordButton.tag = LCERecordButtonState.startRecord.rawValue
        centerImageView.image = UIImage.init(named: "recode_icon_no")
    }
    
    // 结束录音，获得录音文件
    func endRecordGetFile() -> Void {
        timer.invalidate()
        recordTimeLabel.text = "\(recordTime).0"
        bgImageView.image = UIImage.init(named: "add_sound_file_yes")
        deleteButton.isHidden = false
        shapeLayer.strokeEnd = 0
        shapeLayer.removeFromSuperlayer()
        timeLabel.text = "0.0 / " + recordTimeLabel.text!
        recordTime = 0
        recordButton.tag = LCERecordButtonState.playRecord.rawValue
        recordButton.setBackgroundImage(UIImage.init(named: "start_play_button"), for: .normal)
        recordButton.setBackgroundImage(UIImage.init(named: "stop_play_button"), for: .selected)
        centerImageView.image = UIImage.init(named: "play_icon_no")
        recordButton.isSelected = false
    }
    
    // 暂停播放
    func pauseRecord() -> Void {
        timer.invalidate()
        recordButton.tag = LCERecordButtonState.playRecord.rawValue
        recordButton.isSelected = false
    }
    // 结束播放录音
    func endPlayRecord() -> Void {
        recordButton.isSelected = false
        recordButton.tag = LCERecordButtonState.playRecord.rawValue
        timer.invalidate()
        shapeLayer.strokeEnd = 0
        shapeLayer.removeFromSuperlayer()
        recordTime = 0
        timeLabel.text = "0.0 / " + recordTimeLabel.text!
        centerImageView.image = UIImage.init(named: "play_icon_no")
    }
    
    //定时器
    @objc func animate() -> Void {
        // 总时长默认是300
        var recordTotalLength = 300
        if recordButton.tag == LCERecordButtonState.pauseRecord.rawValue {
            recordTotalLength = Int((recordTimeLabel.text! as NSString).floatValue)
        }
        if  round(shapeLayer.strokeEnd * CGFloat(recordTotalLength)) < CGFloat(recordTotalLength) {
            shapeLayer.strokeEnd += 1 / CGFloat(recordTotalLength)
            recordTime += 1
            if recordButton.tag == LCERecordButtonState.pauseRecord.rawValue {
                timeLabel.text = "\(recordTime).0 / " + recordTimeLabel.text!
            }else {
                timeLabel.text = "\(recordTime).0"
            }
            print("\(recordTime)")
        }else{
            if recordButton.tag == LCERecordButtonState.endRecord.rawValue {
                // 自动结束录音
                endRecordGetFile()
            }else {
                // 自动结束播放录音
                endPlayRecord()
            }
        }
    }
    
    // MARK: - 页面布局
    override func updateConstraints() {
        super.updateConstraints()
        self.remindLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo((LCEScreenWidth - 70) * 9 / 44)
        }
        self.bgImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottomMargin.equalTo(self.remindLabel.snp.bottomMargin).offset(0)
        }
        self.recordTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo((LCEScreenWidth - 70) * 9 / 44)
            make.top.equalTo(0)
            make.centerY.equalTo(self.remindLabel.snp.centerY).offset(0)
            make.bottomMargin.equalTo(self.remindLabel.snp.bottomMargin).offset(0)
            make.right.equalTo(-30)
        }
        self.deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(self.remindLabel.snp.centerY).offset(0)
        }
        self.trackImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center).offset(0)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        self.centerImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.trackImageView.snp.center).offset(0)
            make.size.equalTo(CGSize(width: 130, height: 130))
        }
        self.recordButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo((LCEScreenWidth - 104) * 64 / 325)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.recordButton.snp.top).offset(-13)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.left.right.equalTo(0)
        }
    }
    
    // MARK: - 懒加载
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView.init()
        bgImageView.image = UIImage.init(named: "add_sound_file_no")
        return bgImageView
    }()
    lazy var remindLabel: UILabel = {
        let remindLabel = UILabel.init()
        remindLabel.font = UIFont.systemFont(ofSize: 15)
        remindLabel.textColor = lceTextColor
        remindLabel.textAlignment = .center
        remindLabel.text = "录音文件"
        return remindLabel
    }()
    lazy var recordTimeLabel: UILabel = {
        let recordTimeLabel = UILabel.init()
        recordTimeLabel.textColor = .white
        recordTimeLabel.font = UIFont.systemFont(ofSize: 14)
        recordTimeLabel.textAlignment = .left
        
        return recordTimeLabel
    }()
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton.init()
        deleteButton.setImage(UIImage.init(named: "delete_sound_button"), for: .normal)
        deleteButton.addTarget(self, action: #selector(touchDeleteRecordFile(sender:)), for: .touchUpInside)
        deleteButton.isHidden = true
        return deleteButton
    }()
    // 录音圆形进度条
    lazy var trackImageView: UIImageView = {
        let trackImageView = UIImageView.init()
        trackImageView.image = UIImage.init(named: "recoder_bg")
        return trackImageView
    }()
    lazy var centerImageView: UIImageView = {
        let centerImageView = UIImageView.init()
        centerImageView.image = UIImage.init(named: "recode_icon_no")
        return centerImageView
    }()
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.init()
        timeLabel.textAlignment = .center
        timeLabel.textColor = lceTextColor
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.text = "0.0"
        return timeLabel
    }()
    lazy var recordButton: UIButton = {
        let recordButton = UIButton.init()
        recordButton.setBackgroundImage(UIImage.init(named: "start_recode_button"), for: .normal)
        recordButton.setBackgroundImage(UIImage.init(named: "stop_recode_button"), for: .selected)
        recordButton.tag = LCERecordButtonState.startRecord.rawValue
        recordButton.addTarget(self, action: #selector(touchRecordButtonAction(sender:)), for: .touchUpInside)
        return recordButton
    }()
    lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer.init()
        let onePath = UIBezierPath(arcCenter: self.trackImageView.center, radius: 68, startAngle: CGFloat(1.5 * Double.pi), endAngle: CGFloat(3.5 * Double.pi), clockwise: true)
        shapeLayer.path = onePath.cgPath
        shapeLayer.lineWidth = 8
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        return shapeLayer
    }()
    
}

//    倒计时⏳
//    func countDown(_ timeOut: Int){
//        //倒计时时间
//        var timeout = timeOut
//        let queue: DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
//        let xiaobei: DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
//        xiaobei.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
//        //每秒执行
//        xiaobei.setEventHandler(handler: { () -> Void in
//            if(timeout<=0){ //倒计时结束，关闭
//                xiaobei.cancel();
//                DispatchQueue.main.sync(execute: { () -> Void in
//
//                })
//            }else{//正在倒计时
//                let seconds = timeout
//                let strTime = NSString.localizedStringWithFormat("%d", seconds)
//                print(strTime)
//                DispatchQueue.main.sync(execute: { () -> Void in
//
//                })
//                timeout -= 1;
//            }
//        })
//        xiaobei.resume()
//    }
