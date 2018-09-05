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
    
    var keyword: String!
    var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.naviView.title = "首页"
        self.keyword = "街拍"
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
                if response.statusCode == 200 {
                    let data = try? response.mapString()
                    let dataModel: LCESearchImageModel = Mapper<LCESearchImageModel>().map(JSONString: data!)!
                    if page == 1 {
                        weakSelf?.dataArray.removeAll()
                    }
                    weakSelf?.dataArray.append(contentsOf: dataModel.data)
                    weakSelf?.requsetResult(result: true, end: dataModel.data.count < 10)
                }else {
                    LCEProgressHUD.sharedInstance.showInfoWithStatus(status: "请求失败")
                    weakSelf?.requsetResult(result: false, end: true)
                }
            } else {
                LCEProgressHUD.sharedInstance.showInfoWithStatus(status: "请求失败")
                weakSelf?.requsetResult(result: false, end: true)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LCESearchImageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "LCESearchImageTableViewCell") as? LCESearchImageTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("LCESearchImageTableViewCell", owner: self, options: nil)?.first as? LCESearchImageTableViewCell
        }
        cell!.imageCollectionView!.tag = indexPath.row
        let model: LCESearchImageListModel = self.dataArray[indexPath.row] as! LCESearchImageListModel
        cell?.imageModel = model
        cell?.setupImageCollectionView()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model: LCESearchImageListModel = self.dataArray[indexPath.row] as! LCESearchImageListModel
        if (model.searchImages().count == 0) {
            return 104;
        }else {
            return 180
        }
//        // 向上取整 分母图片个数需是浮点数
//        let rowNums = ceilf(Float(Double((model.searchImages().count)) / 3.0))
//        let itemHeight = (LCEScreenWidth - 24 - 2 * 5) / 3
//        return itemHeight * CGFloat(rowNums) + (CGFloat(rowNums) - 1) * 5 + 104
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
