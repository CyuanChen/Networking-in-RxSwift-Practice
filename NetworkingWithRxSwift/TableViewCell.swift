//
//  TableViewCell.swift
//  NetworkingWithRxSwift
//
//  Created by PeterChen on 2019/2/13.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
