//
//  LCEWriteDiaryBottomView.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/22.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEWriteDiaryBottomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() -> Void {
        self.addSubview(self.bgImageView)
        self.addSubview(self.skinButton)
        self.addSubview(self.fontButton)
        self.addSubview(self.labelButton)
    }
    
    override func updateConstraints() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        self.skinButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        self.fontButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.skinButton.snp.right).offset(15)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        self.labelButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.fontButton.snp.right).offset(15)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        super.updateConstraints()
    }
    // MARK: 懒加载
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView.init()
        bgImageView.image = UIImage.init(named: "diary_foot_bg")
        return bgImageView
    }()
    lazy var skinButton: UIButton = {
        let skinButton = UIButton()
        skinButton.setBackgroundImage(UIImage.init(named: "diary_font_button"), for: .normal)
        return skinButton
    }()
    lazy var fontButton: UIButton = {
        let fontButton = UIButton()
        fontButton.setBackgroundImage(UIImage.init(named: "diary_font_button"), for: .normal)
        return fontButton
    }()
    lazy var labelButton: UIButton = {
        let labelButton = UIButton()
        labelButton.setBackgroundImage(UIImage.init(named: "diary_font_button"), for: .normal)
        return labelButton
    }()
    
}
