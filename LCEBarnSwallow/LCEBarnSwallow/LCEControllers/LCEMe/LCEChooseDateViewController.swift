//
//  LCEChooseDateViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/30.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

typealias LCEChooseDateViewControllerBlock = (_ dateTimeStr: String) -> Void

class LCEChooseDateViewController: LCEBaseViewController, LCEChooseDateViewDelegate {
    
    var chooseDateBlock: LCEChooseDateViewControllerBlock?
    
    open var dateTimeStr: String! {
        didSet{
            self.timeLabel.text = dateTimeStr
        }
    }
    
    // 选择时间代理方法
    func chooseDateAndTime(dateTime: String) {
        self.timeLabel.text = dateTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "日期和时间"
        super.addLeftBarItem(target: self, imageName: "common_right1", sel: #selector(leftBarButtonItemAction))
        self.naviView.leftButton.setTitle("取消", for: .normal)
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
        self.view.addSubview(self.timeLabel)
        self.view.addSubview(self.chooseDateView)
        self.updateViewConstraints()
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func rightBarButtonItemAction() -> Void {
        if chooseDateBlock != nil {
            chooseDateBlock!(self.timeLabel.text!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func callBackBlock(_ block: @escaping LCEChooseDateViewControllerBlock) {
        chooseDateBlock = block
    }
    
    // MARK: 按钮响应方法
    
    override func updateViewConstraints() {
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(150)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.height.equalTo(35)
        }
        super .updateViewConstraints()
    }
    // 日期时间
    lazy var timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return timeLabel
    }()
    // 选择日期和时间
    lazy var chooseDateView : LCEChooseDateView = {
        let chooseDateView = LCEChooseDateView.init(frame: CGRect(x: 0, y: self.view.frame.size.height - 300, width: lce_screen_width, height: 300))
        chooseDateView.delegate = self
        chooseDateView.dateTimeStr = dateTimeStr
        return chooseDateView
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
