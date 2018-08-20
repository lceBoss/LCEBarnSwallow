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
            let chooseDateVC = LCEChooseDateViewController()
            chooseDateVC.dateTimeStr = functionBarView.dateTime
            chooseDateVC.callBackBlock {(dateTime) in
                self.functionBarView.dateTime = dateTime
            }
            self.navigationController!.present(chooseDateVC, animated: true, completion: nil)
        case .icon:
            print("选择图标")
            let chooseIconVC = LCEChooseIconViewController()
            self.navigationController?.present(chooseIconVC, animated: true, completion: nil)
        case .photo:
            print("选择照片")
            let choosePhotoVC = LCEChoosePhotoViewController()
            self.navigationController?.present(choosePhotoVC, animated: true, completion: nil)
//            self.functionBarView.photoButton.isSelected = !self.functionBarView.photoButton.isSelected
        case .record:
            print("选择录音")
            let recordVC = LCERecordViewController()
            self.navigationController?.present(recordVC, animated: true, completion: nil)
//            self.functionBarView.recordButton.isSelected = !self.functionBarView.recordButton.isSelected
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
        self.view.addSubview(self.writeTextView)
        self.view.addSubview(self.closeKeyboardBtn)
        self.addKeyboardNotification()
        self.updateViewConstraints()
    }
    // 添加键盘监听
    func addKeyboardNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let notiInfo = notification.userInfo
        let keyboardFrame:CGRect = notiInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height
        let animaDuration:TimeInterval = notiInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animaDuration, animations: {
            self.functionBarView.frame = CGRect(x: (lce_screen_width - 301) / 2, y: -75.4 + 64, width: 301, height: 75.4)
            self.closeKeyboardBtn.frame = CGRect(x: lce_screen_width - 45, y: lce_screen_height - keyboardHeight - 10, width: 45, height: 30)
        }) { (commplete) in
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("键盘即将收回")
        let notiInfo = notification.userInfo
        let animaDuration:TimeInterval = notiInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animaDuration, animations: {
            self.functionBarView.frame = CGRect(x: (lce_screen_width - 301) / 2, y: 64 + 20, width: 301, height: 75.4)
            self.closeKeyboardBtn.frame = CGRect(x: lce_screen_width - 45, y: lce_screen_height + 20, width: 45, height: 30)
        }) { (commplete) in
        }
        
    }

    override func updateViewConstraints() {
        super .updateViewConstraints()
        self.bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-46)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(50)
        }
        self.writeTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.functionBarView.snp.bottom).offset(8)
            make.leftMargin.equalTo(self.functionBarView.snp.leftMargin)
            make.rightMargin.equalTo(self.functionBarView.snp.rightMargin)
            make.bottom.equalTo(self.bottomView.snp.top).offset(-5)
        }
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func rightBarButtonItemAction() -> Void {
        
    }
    @objc func closeKeyboard(sender: UIButton) -> Void {
        self.view.endEditing(true)
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
        let date = NSDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY年MM月dd日 HH:mm"
        functionBarView.dateTime = dateFormater.string(from: date as Date)
        return functionBarView
    }()
    // 编辑区域
    lazy var writeTextView : UITextView = {
        let writeTextView = UITextView()
        writeTextView.backgroundColor = UIColor.clear
        return writeTextView
    }()
    lazy var closeKeyboardBtn : UIButton = {
        let closeKeyboardBtn = UIButton()
        closeKeyboardBtn.frame = CGRect(x: lce_screen_width - 45, y: lce_screen_height + 20, width: 45, height: 30)
        closeKeyboardBtn.setBackgroundImage(UIImage.init(named: "close_keyboard_button"), for: .normal)
        closeKeyboardBtn.addTarget(self, action: #selector(closeKeyboard(sender:)), for: .touchUpInside)
        return closeKeyboardBtn
    }()
    // 底部功能栏
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
