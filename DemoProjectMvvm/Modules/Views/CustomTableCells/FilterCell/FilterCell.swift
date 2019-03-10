//
//  SectionCell.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 18/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
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
