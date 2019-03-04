//
//  SectionCell.swift
//  DemoProjectMvvm
//
//  Created by Arun-Swifty on 18/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var filterLbl: UILabel!

    var gender: StoreContact? {
        didSet {
            filterLbl.text = gender?.gender ?? ""
        }
    }

    var company: StoreContact? {
        didSet {
            filterLbl.text = company?.companyName ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaults()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDefaults()
    }
    
    private func setDefaults() {
        filterLbl.text = ""
    }
}
