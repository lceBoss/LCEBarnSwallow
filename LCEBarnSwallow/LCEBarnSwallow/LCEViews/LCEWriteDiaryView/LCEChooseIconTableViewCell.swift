//
//  LCEChooseIconTableViewCell.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/9/6.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

protocol LCEChooseIconTableViewCellDelegate {
    func chooseIconTableViewCell(paperCollectionSection: Int, selectIndexPath: NSIndexPath) -> Void
}

class LCEChooseIconTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, LCEIconCollectionViewCellDelegate {
    
    var indexPath: NSIndexPath!
    // 存储选中的图标
    var chooseIconDic = [String: String]()
    var delegae: LCEChooseIconTableViewCellDelegate?

    @IBOutlet weak var iconCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconCollectionView.showsVerticalScrollIndicator = false
        self.iconCollectionView.showsHorizontalScrollIndicator = false
        self.iconCollectionView.isPagingEnabled = true
        self.iconCollectionView.isScrollEnabled = true
        self.iconCollectionView.delegate = self
        self.iconCollectionView.dataSource = self
        self.pageControl.isHidden = true
        
        self.iconCollectionView.register(UINib.init(nibName: "LCEIconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LCEIconCollectionViewCell")
    }
    
    func setupIconCollectionView(section: Int) -> Void {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        if section == 2 {
            let itemWidth: CGFloat = (LCEScreenWidth - 7 * 12) / 6
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            flowLayout.sectionInset = UIEdgeInsets.init(top: 5, left: 12, bottom: 50, right: 12)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 12
            flowLayout.minimumInteritemSpacing = 4
        }else {
            let itemWidth: CGFloat = (LCEScreenWidth - 6 * 5) / 5
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            flowLayout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
            flowLayout.minimumLineSpacing = 5
            flowLayout.minimumInteritemSpacing = 5
        }
        self.iconCollectionView.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    // MARK: UICollectionViewDataSource & Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.indexPath.section == 2 {
            return 8
        }else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.indexPath.section == 0 {
            return 7
        }else if self.indexPath.section == 1 {
            return 10
        }else {
            return 18
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LCEIconCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LCEIconCollectionViewCell", for: indexPath) as! LCEIconCollectionViewCell
        
        cell.delegate = self
        cell.iconButton.tag = indexPath.row
        cell.iconButton.isSelected = false
        if self.indexPath.section == 0 {
            cell.iconButton.setImage(UIImage.init(named: "look_weather\(indexPath.row + 1)"), for: .normal)
            cell.iconButton.setImage(UIImage.init(named: "look_weather\(indexPath.row + 1)_select"), for: .selected)
            let indexPathRow: Int = Int(self.chooseIconDic["weather"]!)!
            if indexPath.row == indexPathRow {
                cell.iconButton.isSelected = true
            }
            
        }else if self.indexPath.section == 1 {
            cell.iconButton.setImage(UIImage.init(named: "diary_face\(indexPath.row + 1)"), for: .normal)
            cell.iconButton.setImage(UIImage.init(named: "diary_face\(indexPath.row + 1)_select"), for: .selected)
            let indexPathRow: Int = Int(self.chooseIconDic["kind"]!)!
            if indexPath.row == indexPathRow {
                cell.iconButton.isSelected = true
            }
            
        }else {
            self.pageControl.isHidden = false
            let paperArr = ["one", "two", "three", "four", "five", "six", "women_face", "man_face"]
            cell.iconButton.setImage(UIImage.init(named: "\(paperArr[indexPath.section])\(indexPath.row + 1)"), for: .normal)
            cell.iconButton.setBackgroundImage(UIImage.init(named: "paper_select"), for: .selected)
            cell.iconButton.isSelected = false
            let paperValue: String = self.chooseIconDic["paper"]!
            let index = paperValue.index(of: "-")
            let indexPathSection: Int = Int(paperValue.prefix(upTo: index!))!
            let indexPathRow: Int = Int(paperValue.suffix(from: index!))!
            if indexPathSection == indexPath.section {
                if -indexPathRow == indexPath.row {
                    cell.iconButton.isSelected = true
                }
            }
        }
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = round(scrollView.contentOffset.x / LCEScreenWidth)
        self.pageControl.currentPage = Int(index)
    }
    
    // MARK: - LCEIconCollectionViewCellDelegate
    func selectIconButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let indexPath = NSIndexPath.init(row: sender.tag, section: self.indexPath.section)
        self.delegae?.chooseIconTableViewCell(paperCollectionSection: self.pageControl.currentPage, selectIndexPath: indexPath)
        self.iconCollectionView .reloadData()
        if self.indexPath.section == 0 {
            self.chooseIconDic["weather"] = "\(indexPath.row)"
        }else if self.indexPath.section == 1 {
            self.chooseIconDic["kind"] = "\(indexPath.row)"
        }else {
            self.chooseIconDic["paper"] = "\(self.pageControl.currentPage)-\(indexPath.row)"
            self.iconCollectionView .reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
