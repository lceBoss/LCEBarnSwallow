//
//  LCEChooseIconViewController.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/7/30.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

typealias LCEChooseIconViewControllerBlock = (_ iconDic: Dictionary<String, String>) -> Void

class LCEChooseIconViewController: LCEBaseViewController, LCEChooseIconTableViewCellDelegate {
    
    //存储选中的图标（含有默认值）
    var chooseIconDict: Dictionary<String, String>!
    var currentIndex: Int! = 0
    var chooseIconBlock: LCEChooseIconViewControllerBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.naviView.title = "天气，心情，贴纸"
        
        self.lceGroupTableView?.frame = CGRect(x: 0, y: 64, width: LCEScreenWidth, height: LCEScreenHeight - 64)
        self.lceGroupTableView?.backgroundColor = .white
        view.addSubview(self.lceGroupTableView!)
        
        super.addLeftBarItem(target: self, imageName: "common_right1", sel: #selector(leftBarButtonItemAction))
        self.naviView.leftButton.setTitle("取消", for: .normal)
        super.addRightBarItem(target: self, imageName: "common_right1_save", sel: #selector(rightBarButtonItemAction))
    }
    
    @objc override func leftBarButtonItemAction() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func rightBarButtonItemAction() -> Void {
        if chooseIconBlock != nil {
            chooseIconBlock!(self.chooseIconDict)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableViewCellDataSource & Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LCEChooseIconTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "LCEChooseIconTableViewCell" + "\(indexPath.row)") as? LCEChooseIconTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("LCEChooseIconTableViewCell", owner: self, options: nil)?.first as? LCEChooseIconTableViewCell
            cell?.delegae = self
        }
        cell?.indexPath = indexPath as NSIndexPath
        cell?.chooseIconDic = self.chooseIconDict
        cell?.iconCollectionView.tag = 100 + indexPath.section
        cell?.setupIconCollectionView(section: indexPath.section)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.frame = CGRect(x: 0, y: 0, width: LCEScreenWidth, height: 40)
        let label = UILabel.init()
        label.textColor = lceTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect(x: 12, y: 10, width: LCEScreenWidth, height: 20)
        if section == 0 {
            label.text = "天气"
        }else if section == 1 {
            label.text = "心情"
        }else {
            label.text = "贴纸"
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            let itemWidth: CGFloat = (LCEScreenWidth - 7 * 12) / 6
            return 5 + 3 * itemWidth + 2 * 12 + 50
        }else {
            let itemWidth: CGFloat = (LCEScreenWidth - 6 * 5) / 5
            return 5 * 3 + 2 * itemWidth
        }
    }
    
    // MARK: - LCEChooseIconTableViewCellDelegate
    func chooseIconTableViewCell(paperCollectionSection: Int, selectIndexPath: NSIndexPath) {
        if selectIndexPath.section == 0 {
            self.chooseIconDict["weather"] = "\(selectIndexPath.row)"
        }else if selectIndexPath.section == 1 {
            self.chooseIconDict["kind"] = "\(selectIndexPath.row)"
        }else {
            self.chooseIconDict["paper"] = "\(paperCollectionSection)-\(selectIndexPath.row)"
        }
    }
    
    func callBackBlock(_ block: @escaping LCEChooseIconViewControllerBlock) {
        chooseIconBlock = block
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
