//
//  LCESearchImageTableViewCell.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/28.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit
import Kingfisher

class LCESearchImageTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    open var imageModel: LCESearchImageListModel! {
        didSet {
            guard let imageModel = imageModel  else {
                return
            }
            self.titleLabel.text = imageModel.title
            self.keyLabel.text = imageModel.keyword
            self.timeLabel.text = imageModel.create_date
            if (imageModel.searchImages().count == 0) {
                self.imageCollectionView.isHidden = true
            } else {
                self.imageCollectionView.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageCollectionView.showsVerticalScrollIndicator = false
        self.imageCollectionView.showsHorizontalScrollIndicator = false
        self.imageCollectionView.isPagingEnabled = false
        self.imageCollectionView.isScrollEnabled = false
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        
        self.imageCollectionView.register(UINib.init(nibName: "LCEImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LCEImageCollectionViewCell")
    }
    
    func setupImageCollectionView() -> Void {
        if self.imageModel.searchImages().count <= 0 {
            return
        }
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let itemWidth: CGFloat = (LCEScreenWidth - 24 - 2 * 5) / 3
        if self.imageModel.searchImages().count == 1 {
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 340 / 702)
        }else {
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 0
        self.imageCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        
    }
    
    // MARK: UICollectionViewDataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageModel.searchImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LCEImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LCEImageCollectionViewCell", for: indexPath) as! LCEImageCollectionViewCell
        let image_url = self.imageModel.searchImages()[indexPath.row]
        cell.imageView.kf.setImage(with: URL.init(string: image_url as! String), placeholder: UIImage.init(named: "icon_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
