//
//  LCEPhotoCollectionViewCell.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/9/29.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

protocol LCEPhotoCollectionViewCellDelegate {
    func photoCollectionViewCellDeletePhoto(index: Int) -> Void
}

class LCEPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: LCEPhotoCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func touchDeleteButtonAction(_ sender: UIButton) {
        print("click sender tag \(sender.tag)")
        self.delegate?.photoCollectionViewCellDeletePhoto(index: sender.tag)
    }
    
}
