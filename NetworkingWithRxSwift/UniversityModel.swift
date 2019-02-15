//
//  UniversityModel.swift
//  NetworkingWithRxSwift
//
//  Created by PeterChen on 2019/2/15.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation

struct UniversityModel: Codable {
    let name: String
    let webPages: [String]?
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case webPages = "web_pages"
        case country
    }
    
    var description: String {
        get {
            if let webPage = webPages?.first {
                return "\(country) • \(webPage)"
            } else {
                return country
            }
        }
    }
}
