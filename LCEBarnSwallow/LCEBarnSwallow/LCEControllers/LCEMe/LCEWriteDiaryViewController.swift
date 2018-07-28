//
//  LCEWriteDiaryViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/14.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEWriteDiaryViewController: LCEBaseViewController, LCEWriteDiaryFunctionBarViewDelegate {
    
    func selectFunctionBar(type: functionBarType) {
        switch type {
        case .date:
            print("选择日期")
        case .icon:
            print("选择图标")
        case .photo:
            print("选择照片")
            self.functionBarView.photoButton.isSelected = !self.functionBarView.photoButton.isSelected
        case .record:
            self.functionBarView.recordButton.isSelected = !self.functionBarView.recordButton.isSelected
            print("选择录音")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "写日记"
        super.addLeftBarItem(target: self, imageName: "common_goback1", sel: #selector(leftBarButtonItemAction))
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.functionBarView)
        self.view.addSubview(self.bottomView)
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() -> Void {
        self.bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-46)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(50)
        }
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func rightBarButtonItemAction() -> Void {
        
    }
    
    // MARK: 懒加载
    lazy var bgImageView : UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        bgImageView.clipsToBounds = true
        bgImageView.image = UIImage.init(named: "writing_paper")
        return bgImageView
    }()
    // 功能栏
    lazy var functionBarView : LCEWriteDiaryFunctionBarView = {
        let functionBarView = LCEWriteDiaryFunctionBarView.init(frame: CGRect(x: (lce_screen_width - 301) / 2, y: 64 + 20, width: 301, height: 75.4))
        functionBarView.delegate = self
        return functionBarView
    }()
    lazy var bottomView:UIView = {
        let bottomView = UIView()
        let bottomBgImageView = UIImageView()
        bottomBgImageView.frame = CGRect(x: 0, y: 0, width: lce_screen_width, height: 50)
        bottomBgImageView.image = UIImage.init(named: "diary_foot_bg")
        bottomView.addSubview(bottomBgImageView)
        return bottomView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
