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

class LCEHomeViewController: LCEBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
//    var tableView: UITableView!
    var dataArray: Array<LCESearchImageListModel> = []
    var keyword: String!
    var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.naviView.title = "首页"
        self.view.addSubview(tableView)
        self.keyword = "朴信惠"
        self.page = 1
        
        weak var weakSelf = self
        SearchImageProvider.request(.imageList(keyword: self.keyword, page: self.page)) {result in
            if case let .success(response) = result {
                let data = try? response.mapString()
                let dataModel: LCESearchImageModel = Mapper<LCESearchImageModel>().map(JSONString: data!)!
                if self.page == 1 {
                    weakSelf?.dataArray.removeAll()
                }
                weakSelf?.dataArray += dataModel.data
                DispatchQueue.main.async{
                    weakSelf?.tableView.reloadData()
                }
            }
        }
        
    }
    
    fileprivate func requestSearchImage(keyword: String, page: Int) -> Void {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell.init()
        let model: LCESearchImageListModel = self.dataArray[indexPath.row]
        cell.textLabel?.text = model.title
        return cell
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 49 - 64))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
