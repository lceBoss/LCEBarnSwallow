//
//  LCEChooseIconViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/30.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEChooseIconViewController: LCEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "天气，心情，贴纸"
        super.addLeftBarItem(target: self, imageName: "common_right1", sel: #selector(leftBarButtonItemAction))
        self.naviView.leftButton.setTitle("取消", for: .normal)
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func rightBarButtonItemAction() -> Void {
        
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
