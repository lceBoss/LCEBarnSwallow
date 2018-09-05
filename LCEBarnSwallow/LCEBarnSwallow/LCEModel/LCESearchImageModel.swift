//
//  LCESearchImageModel.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/8/28.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

//import UIKit
//
//class LCESearchImageModel: NSObject {
//
//}

import UIKit
import ObjectMapper

class LCESearchImageModel: Mappable {
    
    var data: [LCESearchImageListModel] = []
    
    required init?(map: Map) {
        if map.JSON["data"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class LCESearchImageListModel: Mappable {
    
    // 关键词
    var keyword: String?
    // 组图id
    var group_id: String?
    var title: String?
    var image_urls: String?
    var create_date: String?
    
    required init?(map: Map) {
        if map.JSON["keyword"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        keyword <- map["keyword"]
        group_id <- map["group_id"]
        title <- map["title"]
        image_urls <- map["image_urls"]
        create_date <- map["create_date"]
    }
    
    func searchImages() -> Array<Any> {
        let searchImages: Array<Any>  = (image_urls?.components(separatedBy: ","))!
        return searchImages
    }
    
    
    
}
