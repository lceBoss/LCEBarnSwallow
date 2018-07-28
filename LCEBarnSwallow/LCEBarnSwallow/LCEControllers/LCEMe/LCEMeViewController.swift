//
//  LCEMeViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEMeViewController: LCEBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        self.naviView.title = "我的"
        self.view .addSubview(self.writeButton)
    }
    
    // 点击写日记按钮
    @objc func touchWriteDiaryButton(sender:UIButton) -> Void {
        let writeDiaryVC = LCEWriteDiaryViewController()
        self.navigationController!.pushViewController(writeDiaryVC, animated: true)
    }
    
    // 懒加载
    lazy var writeButton : UIButton = {
        let writeButton = UIButton()
        writeButton.setTitle("写日记", for: UIControlState.normal)
        writeButton.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        writeButton.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        writeButton.backgroundColor = UIColor.orange
        writeButton.center = self.view.center
        writeButton.layer.cornerRadius = 10
        writeButton.addTarget(self, action: #selector(touchWriteDiaryButton(sender:)), for: UIControlEvents.touchUpInside)
        return writeButton
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
