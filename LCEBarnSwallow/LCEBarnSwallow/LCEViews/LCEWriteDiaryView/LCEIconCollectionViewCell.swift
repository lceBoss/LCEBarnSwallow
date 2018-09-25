//
//  LCEIconCollectionViewCell.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/9/6.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import UIKit

protocol LCEIconCollectionViewCellDelegate {
    func selectIconButton(_ sender: UIButton) -> Void
}

class LCEIconCollectionViewCell: UICollectionViewCell {
    
    var delegate: LCEIconCollectionViewCellDelegate?

    @IBOutlet weak var iconButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func selectIconButtonAction(_ sender: UIButton) {
        self.delegate?.selectIconButton(sender)
    }
}
