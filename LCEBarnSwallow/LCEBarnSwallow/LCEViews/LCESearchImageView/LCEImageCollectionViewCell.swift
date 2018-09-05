//
//  LCEImageCollectionViewCell.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/29.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

class LCEImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
    }

}
