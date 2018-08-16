//
//  LCENaviView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/14.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import SnapKit

class LCENaviView: UIView {
    
    open var title: String? {
        didSet{
            self.middleButton.setTitle(title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addLeftBarItem(target:UIViewController, imageName:String, sel:Selector) -> Void {
        self.leftButton.setBackgroundImage(UIImage.init(named: imageName), for: .normal)
        self.leftButton.setTitle("", for: .normal)
        self.leftButton.addTarget(target, action: sel, for: .touchUpInside)
    }
    
    open func addLeftBarItem(target:UIViewController, title:String, sel:Selector) -> Void {
        self.leftButton.setTitle(title, for: .normal)
        self.leftButton.imageView?.isHidden = true
        self.leftButton.addTarget(target, action: sel, for: .touchUpInside)
    }
    
    open func addRightBarItem(target:UIViewController, imageName:String, sel:Selector) -> Void {
        self.rightButton.setBackgroundImage(UIImage.init(named: imageName), for: .normal)
        self.rightButton.addTarget(target, action: sel, for: .touchUpInside)
    }
    
    open func addRightBarItem(target:UIViewController, title:String, sel:Selector) -> Void {
        self.rightButton.setTitle(title, for: .normal)
        self.rightButton.addTarget(target, action: sel, for: .touchUpInside)
    }
    open func setupNaviBgImage(imageName:String) -> Void {
        self.bgImageView.image = UIImage.init(named: imageName)
    }
    
    func setupViews() -> Void {
        self.addSubview(statusView)
        self.addSubview(bgImageView)
        self.addSubview(leftView)
        self.addSubview(middleView)
        self.addSubview(rightView)
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        
        self.statusView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(20)
        }
        self.bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.bottom.equalTo(0)
        }
        self.leftView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.top.equalTo(self.statusView.snp.bottom).offset(0)
            make.width.equalTo(lce_screen_width * 1 / 4)
        }
        self.rightView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.top.equalTo(self.statusView.snp.bottom).offset(0)
            make.width.equalTo(lce_screen_width * 1 / 4)
        }
        self.middleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.statusView.snp.bottom).offset(0)
            make.left.equalTo(self.leftView.snp.right).offset(5)
            make.right.equalTo(self.rightView.snp.left).offset(-5)
            make.bottom.equalTo(0)
        }
        
        self.leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(6)
            make.centerY.equalTo(self.leftView)
            make.size.equalTo(CGSize(width: 47, height: 30))
        }
        
        self.rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-6)
            make.centerY.equalTo(self.rightView)
            make.size.equalTo(CGSize(width: 45, height: 30))
        }
        
        self.middleButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self.middleView)
        }
    }
    
    lazy var statusView : UIView = {
        let statusView = UIView()
        statusView.backgroundColor = UIColor.black
        return statusView
    }()
    
    lazy var bgImageView : UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        bgImageView.clipsToBounds = true
        return bgImageView
    }()
    
    lazy var leftView : UIView = {
        let leftView = UIView()
        leftView.addSubview(self.leftButton)
        return leftView
    }()
    
    lazy var middleView : UIView = {
        let middleView = UIView()
        middleView.addSubview(self.middleButton)
        return middleView
    }()
    
    lazy var rightView : UIView = {
        let rightView = UIView()
        rightView.addSubview(self.rightButton)
        return rightView
    }()
    
    lazy var leftButton:UIButton = {
        let leftButton = UIButton()
        leftButton.setTitleColor(.white, for: .normal)
        leftButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftButton.titleLabel?.textAlignment = NSTextAlignment.left
        return leftButton
    }()
    
    lazy var rightButton:UIButton = {
        let rightButton = UIButton()
        rightButton.setTitleColor(.white, for: .normal)
        rightButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightButton.titleLabel?.textAlignment = NSTextAlignment.right
        return rightButton
    }()
    
    lazy var middleButton:UIButton = {
        let middleButton = UIButton()
        middleButton.setTitleColor(.white, for: .normal)
        middleButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        middleButton.titleLabel?.textAlignment = NSTextAlignment.center
        return middleButton
    }()
    
}
