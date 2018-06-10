//
//  CellUITableViewCell.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 10/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
import UIKit

class CellUITableViewCell: UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var language: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
