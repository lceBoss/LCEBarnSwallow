//
//  LCERecordViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/30.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCERecordViewController: LCEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "录音"
        self.view.backgroundColor = .white
        super.addLeftBarItem(target: self, imageName: "common_right1", sel: #selector(leftBarButtonItemAction))
        self.naviView.leftButton.setTitle("取消", for: .normal)
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
        setUpViews()
    }
    
    func setUpViews() -> Void {
        self.view.addSubview(self.recordProgressView)
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func rightBarButtonItemAction() -> Void {
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.recordProgressView.snp.makeConstraints { (make) in
            make.top.equalTo(LCENavHeight + 60)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.bottom.equalTo(-20)
            make.width.equalTo(LCEScreenWidth - 70)
        }
    }
    
    // MARK: - Lazy loading
    lazy var recordProgressView: LCERecordProgressView = {
        let recordProgressView = LCERecordProgressView.init()
        return recordProgressView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
