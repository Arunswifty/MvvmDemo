//
//  DetailVc.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 18/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var aboutTxtView: UITextView!
    
    var detailData: StoreContact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        let userName = detailData?.firstName ?? ""
        title =  userName + " Profile"
        navigationController?.navigationBar.tintColor = .white
    }
    
    fileprivate func setUpData() {
        let companyName = detailData?.companyName ?? ""
        let gender = detailData?.gender ?? ""
        let phoneNumber = detailData?.phoneNumber ?? ""
        
        companyLabel.text = "Company Name: " + companyName
        genderLabel.text = "Gender: " + gender
        phoneNumberLabel.text = "Phone Number: " + phoneNumber
        aboutTxtView.text = detailData?.aboutCompany
    }
    
}
