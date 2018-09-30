//
//  LCEProgressHUD.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/18.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import SVProgressHUD

// 提示框风格（背景颜色：白色、灰黑色、自定义）
enum LCEProgressHUDStyle {
    case LCEProgressHUDStyleLight
    case LCEProgressHUDStyleDark
    case LCEProgressHUDStyleCustom
}

class LCEProgressHUD: NSObject {
    /** 全局单例对象*/
    static let sharedInstance = LCEProgressHUD()
    
    override init() {
        super.init()
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 17))
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2.0)
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
    }
    /*****   以下只列了部分常用功能方法，如若需要可自行添加   ****/
    // 纯菊花
    func show() -> Void {
        SVProgressHUD.show()
    }
    // 菊花和字
    func showWithStatus(status: String) -> Void {
        SVProgressHUD.show(withStatus: status)
    }
    // 感叹号和字
    func showInfoWithStatus(status: String) -> Void {
        SVProgressHUD.showInfo(withStatus: status)
    }
    // 成功提示
    func showSuccessWithStatus(status: String) -> Void {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    // 失败或报错提示
    func showErrorWithStatus(status: String) -> Void {
        SVProgressHUD.showError(withStatus: status)
    }
    // 关闭hud
    func dismiss() -> Void {
        SVProgressHUD.dismiss()
    }
    // 设置默认风格类型（白色、灰褐色）
    func setDefaultStyle(style: LCEProgressHUDStyle) -> Void {
        switch style {
        case .LCEProgressHUDStyleDark:
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        case .LCEProgressHUDStyleLight:
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        default:
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        }
    }
    
}


