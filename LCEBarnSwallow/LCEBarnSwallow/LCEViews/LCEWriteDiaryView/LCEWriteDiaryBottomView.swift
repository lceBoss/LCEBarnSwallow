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
    }
    
    override func updateConstraints() {
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
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
        skinButton.setImage(UIImage.init(named: ""), for: <#T##UIControlState#>)
        return skinButton
    }()
    
}
