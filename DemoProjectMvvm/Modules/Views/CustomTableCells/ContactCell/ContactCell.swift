//
//  ContactCell.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 18/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!

    var dataModel: StoreContact? {
        didSet {
            let firstName = dataModel?.firstName ?? " "
            let lastName =  dataModel?.lastName ?? ""
            nameLbl.text = firstName + " " + lastName
            genderLbl.text = dataModel?.gender ?? ""
            companyLbl.text = dataModel?.companyName ?? ""
            phoneLbl.text = dataModel?.phoneNumber ?? ""
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
        nameLbl.text = ""
        genderLbl.text = ""
        companyLbl.text = ""
        phoneLbl.text = ""
    }
}
