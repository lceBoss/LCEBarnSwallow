//
//  LCEHomeViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEHomeViewController: LCEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.view.addSubview(testButton)
        self.view.addSubview(dismissButton)
        // Do any additional setup after loading the view.
    }
    
    lazy var testButton: UIButton = {
        let testButton: UIButton = UIButton.init(type: .custom)
        testButton.frame = CGRect(x: 80, y: 100, width: 140, height: 60)
        testButton.backgroundColor = UIColor.orange
        testButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        testButton.setTitle("show", for: UIControlState.normal)
        testButton.addTarget(self, action: #selector(clickTestButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return testButton
    }()
    
    lazy var dismissButton: UIButton = {
        let dismissButton: UIButton = UIButton.init(type: UIButtonType.custom)
        dismissButton.frame = CGRect(x: 80, y: 200, width: 140, height: 60)
        dismissButton.backgroundColor = UIColor.orange
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        dismissButton.setTitle("消失", for: .normal)
        dismissButton.addTarget(self, action: #selector(clickDismissButtonAction(_:)), for: .touchUpInside)
        return dismissButton
    }()
    
    @objc fileprivate func clickTestButtonAction(_ sender: UIButton) -> Void {
        LCEProgressHUD.sharedInstance.setDefaultStyle(style: LCEProgressHUDStyle.LCEProgressHUDStyleDark)
        LCEProgressHUD.sharedInstance.showSuccessWithStatus(status: "请求成功")
    }
    
    @objc fileprivate func clickDismissButtonAction(_ sender: UIButton) -> Void {
        LCEProgressHUD.sharedInstance.dismiss()
    }
    
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
