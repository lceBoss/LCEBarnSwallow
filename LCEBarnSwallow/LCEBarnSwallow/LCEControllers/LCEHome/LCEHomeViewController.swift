//
//  LCEHomeViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class LCEHomeViewController: LCEBaseViewController {
    
//    var tableView: UITableView!
//    var dataArray: Array<LCESearchImageListModel> = []
    var keyword: String!
    var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.naviView.title = "首页"
        self.keyword = "朴信惠"
        self.page = 1
        
        self.lceTableView?.frame = CGRect(x: 0, y: 64, width: LCEScreenWidth, height: LCEScreenHeight - 64 - 49)
        view.addSubview(self.lceTableView!)
        
        // Network
        requestSearchImages(keyword: self.keyword, page: self.page)
        weak var weakSelf = self
        addMJRefreshHeaderView { (page) in
            weakSelf?.requestSearchImages(keyword:(weakSelf?.keyword)!, page:page!)
        }
        self.addMJRefreshFooterView { (page) in
            weakSelf?.requestSearchImages(keyword: (weakSelf?.keyword)!, page: page!)
        }
        
    }
    
    func requestSearchImages(keyword: String, page: Int) -> Void {
        weak var weakSelf = self
        SearchImageProvider.request(.imageList(keyword: keyword, page: page)) {result in
            
            if case let .success(response) = result {
                let data = try? response.mapString()
                let dataModel: LCESearchImageModel = Mapper<LCESearchImageModel>().map(JSONString: data!)!
                if page == 1 {
                    weakSelf?.dataArray.removeAll()
                }
                weakSelf?.dataArray.append(contentsOf: dataModel.data)
                DispatchQueue.main.async{
                    weakSelf?.lceTableView?.reloadData()
                }
                weakSelf?.requsetResult(result: true, end: dataModel.data.count < 10)
            } else {
                LCEProgressHUD.sharedInstance.showInfoWithStatus(status: "请求失败")
                weakSelf?.requsetResult(result: false, end: true)
            }
        }
    }
    
    fileprivate func requestSearchImage(keyword: String, page: Int) -> Void {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell.init()
        let model: LCESearchImageListModel = self.dataArray[indexPath.row] as! LCESearchImageListModel
        cell.textLabel?.text = model.title
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
