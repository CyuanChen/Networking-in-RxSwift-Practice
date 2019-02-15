//
//  UniversityRequest.swift
//  NetworkingWithRxSwift
//
//  Created by PeterChen on 2019/2/15.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation

class UniversityRequest: APIRequest {
    var method = RequestType.GET
    var path = "search"
    var parameters = [String: String]()
    
    init(name: String) {
        parameters["name"] = name
    }
}
