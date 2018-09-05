//
//  LCEBaseViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import MJRefresh

//// 屏幕宽
//let lce_screen_width : CGFloat = UIScreen.main.applicationFrame.size.width
//// 屏幕高
//let lce_screen_height : CGFloat = UIScreen.main.applicationFrame.size.height

/** 上拉加载结束回调*/
public typealias LCEMJFooterLoadCompleteBlock = (Int?) -> Swift.Void
/** 下拉加载结束回调*/
public typealias LCEMJHeaderLoadCompleteBlock = (Int?) -> Swift.Void

let LCETabViewFrame = CGRect(x: 0, y: 0, width: LCEScreenWidth, height: (LCEScreenHeight - LCENavHeight))

fileprivate let tableViewTag: Int = 970425

class LCEBaseViewController: UIViewController {
    
    // dataSource
    var dataArray: [Any] = []
    // page
    var requestPage: Int = 1
    
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
    
    // MARK: - MJRefresh
    func addMJRefreshFooterView(completeBlock: LCEMJFooterLoadCompleteBlock? = nil) {
        weak var weakSelf = self
        let tableView = currentTableView()
        
        tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            weakSelf?.requestPage += 1
            completeBlock?(weakSelf?.requestPage)
        })
    }
    
    
    func addMJRefreshHeaderView(completeBlock: LCEMJHeaderLoadCompleteBlock? = nil) {
        weak var weakSelf = self
        let tableView = currentTableView()
        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            if tableView?.mj_footer != nil {
                tableView?.mj_footer.resetNoMoreData()
            }
            weakSelf?.requestPage = 1
            completeBlock?(weakSelf?.requestPage)
        })
    }
    
    /// 上下拉结果处理
    /// - Parameters:
    ///   - result: 请求结果
    ///   - end: 是否结束
    func requsetResult(result: Bool, end: Bool) {
        let tableView = currentTableView()
        tableView?.mj_header.endRefreshing()
        if (tableView?.mj_footer != nil) {
            tableView?.mj_footer.endRefreshing()
        }
        if end {
            if (tableView?.mj_footer != nil) {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
            tableView?.reloadData()
            return
        }
        if !result && (requestPage > 1) {
            requestPage -= 1
        }
        else {
            tableView?.reloadData()
        }
    }
    
    fileprivate func currentTableView() -> UITableView? {
        let tableView: UITableView = view.viewWithTag(tableViewTag) as! UITableView
        return tableView
    }
    
    // plain tableView
    lazy var lceTableView: UITableView? = {
        let lceTableView = UITableView(frame: LCETabViewFrame, style: .plain)
        lceTableView.delegate = self
        lceTableView.dataSource = self
        lceTableView.separatorStyle = .none
        lceTableView.tag = tableViewTag
        lceTableView.backgroundColor = lceBgColor
        if #available(iOS 11.0, *) {
            lceTableView.contentInsetAdjustmentBehavior = .never
        }
        return lceTableView
    }()
    
    // group tableView
    lazy var lceGroupTableView: UITableView? = {
        let lceGroupTableView = UITableView(frame: LCETabViewFrame, style: .grouped)
        lceGroupTableView.delegate = self
        lceGroupTableView.dataSource = self
        lceGroupTableView.separatorStyle = .none
        lceGroupTableView.tag = tableViewTag
        lceGroupTableView.backgroundColor = lceBgColor
        if #available(iOS 11.0, *) {
            lceGroupTableView.contentInsetAdjustmentBehavior = .never
        }
        return lceGroupTableView
    }()

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

extension LCEBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = UITableViewCell()
        return cell!
    }
}
