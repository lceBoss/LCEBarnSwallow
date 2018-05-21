//
//  LCESearchImageApi.swift
//  LCEBarnSwallow
//
//  Created by 妖狐小子 on 2018/5/21.
//  Copyright © 2018年 yaohuxiaozi. All rights reserved.
//

import Foundation
import Moya

let SearchImageProvider = MoyaProvider<SearchImage>()

public enum SearchImage {
    case imageList(keyword: String, page: Int)
    
}

extension SearchImage: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .imageList(keyword: _, page: _):
            return URL(string: "http://127.0.0.1:5000")!
        }
    }
    
    public var path: String {
        switch self {
        case .imageList(keyword: _, page: _):
            return "/toutiao/searchImage"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .imageList(keyword: let keyword, page: let page):
            var params: [String: Any] = [:]
            params["keyword"] = keyword
            params["page"] = page
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    
    public var validate: Bool {
        return false
    }
    
    
    public var headers: [String: String]? {
        return ["xiaobei": "python"]
    }
    
    
}
