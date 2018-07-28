//
//  LCEHomeViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/17.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import SwiftyJSON

class LCEHomeViewController: LCEBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
//    var tableView: UITableView!
    var dataArray:Array<JSON> = []
    var keyword: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.naviView.title = "首页"
        self.view.addSubview(tableView)
        SearchImageProvider.request(.imageList(keyword: "街拍", page: 1)) {result in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                self.dataArray = json["data"].arrayValue
                DispatchQueue.main.async{
                    self.tableView.reloadData()
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
        let title: String = self.dataArray[indexPath.row]["title"].stringValue
        cell.textLabel?.text = title
        return cell
    }
    
    lazy var tableView: UITableView = {
        var tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 49))
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
