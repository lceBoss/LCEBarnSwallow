//
//  LCETools.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/28.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

public let LCENavHeight: CGFloat = 64
public let LCEMainBounds: CGRect = UIScreen.main.bounds
public let LCEScreenWidth: CGFloat = LCEMainBounds.size.width
public let LCEScreenHeight: CGFloat = LCEMainBounds.size.height
public let LCECurrentVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

/// iPhone 6
public func LCEScreenPixwn(_ px: CGFloat) -> CGFloat {
    return (LCEScreenWidth / 375.0) * px;
}

// iPhone 5
public func LCEScreenPixw(_ px: CGFloat) -> CGFloat {
    return (LCEScreenWidth / 320.0) * px;
}
