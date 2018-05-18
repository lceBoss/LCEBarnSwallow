//
//  LCETabBarController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

private let LCETabBarHeight: CGFloat = 49
private let LCETabBarLabelTag: Int = 100
private let LCETabBarButtonTag: Int = 999

class LCETabBarController: UITabBarController {
    
    private let itemTitles = ["首页","我的"]
    private let defaultItemColor: UIColor = UIColor.lightGray
    private let selectItemColor: UIColor = UIColor.black
    
    private var itemButtons = [UIButton]()
    
    var homeVC: LCEHomeViewController!
    var meVC: LCEMeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.tabBar.isHidden = true
        self.view.addSubview(tabBarView)
        // items按钮配置
        configureItemButtons()
    }
    
    private func configureItemButtons() {
        
        homeVC = LCEHomeViewController()
        meVC = LCEMeViewController()
        self.viewControllers = [homeVC, meVC]
        
        let buttonWidth = self.view.frame.size.width / CGFloat(itemTitles.count)
        for i in 0..<itemTitles.count {
//            let defaultIcon = defaultIcons[i]
//            let selectIcon = selectIcons[i]
            let itemButton = UIButton(type: .custom)
            let edgeInsets = (buttonWidth - 24) / 2;
            itemButton.imageEdgeInsets = UIEdgeInsetsMake(5, edgeInsets, 20, edgeInsets)
            itemButton.tag = LCETabBarButtonTag + i
            itemButton.frame = CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: LCETabBarHeight)
//            itemButton.setImage(UIImage(named: defaultIcon), for: .normal)
//            itemButton.setImage(UIImage(named: selectIcon), for: .selected)
            itemButton.addTarget(self, action: #selector(itemButtonAction), for: .touchUpInside)
            itemButton.titleLabel?.textAlignment = .center
            itemButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
            itemButton.setTitleColor(defaultItemColor, for: .normal)
            itemButton.setTitleColor(selectItemColor, for: .selected)
            itemButton.setTitle(itemTitles[i], for: .normal)
            tabBarView.addSubview(itemButton)
            if (i == 0) {
                itemButton.isSelected = true
                itemButtonAction(itemButton)
            }
            itemButtons.append(itemButton)
        }
    }
    /// MARK: ButtonAction
    @objc fileprivate func itemButtonAction(_ itemButton: UIButton) {
        if itemButton.isSelected {
            return
        }
        let index: Int = itemButton.tag - LCETabBarButtonTag
        self.selectedIndex = index
        
        let currentVC = self.viewControllers![index]
        self.title = currentVC.title;
        self.navigationItem.titleView = currentVC.navigationItem.titleView;
        self.navigationItem.rightBarButtonItem = currentVC.navigationItem.rightBarButtonItem;
        self.navigationItem.leftBarButtonItem = currentVC.navigationItem.leftBarButtonItem;
        
        for item in itemButtons {
            let selectStatus = item === itemButton
            item.isSelected = selectStatus
        }
    }
    
    private lazy var tabBarView: UIView = {
        let tabBarView = UIView(frame: CGRect(x: 0, y: (self.view.frame.height - LCETabBarHeight), width: self.view.frame.width, height: LCETabBarHeight))
        tabBarView.backgroundColor = UIColor.white
        return tabBarView
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
