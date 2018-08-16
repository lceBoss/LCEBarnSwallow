//
//  LCEBaseViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

// 默认背景灰色
let lceBgColor : UIColor = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
// 屏幕宽
let lce_screen_width : CGFloat = UIScreen.main.applicationFrame.size.width
// 屏幕高
let lce_screen_height : CGFloat = UIScreen.main.applicationFrame.size.height

class LCEBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = lceBgColor
        view.translatesAutoresizingMaskIntoConstraints = true
        automaticallyAdjustsScrollViewInsets = false
        if (self.navigationController?.viewControllers.count) != nil {
            if ((self.navigationController?.viewControllers.count))! >= 2 {
                self.addLeftBarItem(target: self, imageName: "common_goback1", sel: #selector(leftBarButtonItemAction))
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.view .addSubview(naviView)
        naviView.setupNaviBgImage(imageName: "navigation_bg_ret")
        print("当前视图控制器:",self.classForCoder)
    }
    @objc func leftBarButtonItemAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: 导航按钮
    func addLeftBarItem(target:UIViewController, title:String, sel:Selector) -> Void {
        naviView.addLeftBarItem(target:target, title: title, sel: sel)
    }
    func addLeftBarItem(target:UIViewController, imageName:String, sel:Selector) -> Void {
        naviView.addLeftBarItem(target: target, imageName: imageName, sel: sel)
    }
    func addRightBarItem(target:UIViewController, title:String, sel:Selector) -> Void {
        naviView.addRightBarItem(target: target, title: title, sel: sel)
    }
    func addRightBarItem(target:UIViewController, imageName:String, sel:Selector) -> Void {
        naviView.addRightBarItem(target: target, imageName: imageName, sel: sel)
    }
    // MARK: 懒加载
    lazy var naviView : LCENaviView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        let naviView = LCENaviView.init(frame: frame)
        return naviView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
