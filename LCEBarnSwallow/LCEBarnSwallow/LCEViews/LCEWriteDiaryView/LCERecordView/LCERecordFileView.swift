//
//  LCERecordFileView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/10/8.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCERecordFileView: UIView {
    
    open var recordTime: String! {
        didSet {
            self.bgImageView.image = UIImage.init(named: "add_sound_file_yes")
            self.recordTimeLabel.text = recordTime + ".0"
            self.deleteButton.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() -> Void {
        self.addSubview(remindLabel)
        self.addSubview(bgImageView)
        self.addSubview(recordTimeLabel)
        self.addSubview(deleteButton)
    }
    
    @objc func touchDeleteRecordFile(sender: UIButton) -> Void {
        self.bgImageView.image = UIImage.init(named: "add_sound_file_no")
        self.recordTimeLabel.text = ""
        self.deleteButton.isHidden = true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.remindLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.recordTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo((LCEScreenWidth - 70) * 9 / 44)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-30)
        }
        self.deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
    }
    
    // MARK: - Lazy loading
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
}
