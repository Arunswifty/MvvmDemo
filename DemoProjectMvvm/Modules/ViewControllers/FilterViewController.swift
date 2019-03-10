//
//  FilterDataVc.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 18/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

enum Section: Int {
    case gender = 0
    case companyName = 1
}

protocol FilterProtocol {
    func updateData(myData: Results<StoreContact>)
}

class FilterViewController: UIViewController {
    
    var filterData: FilterProtocol?
    
    @IBOutlet weak var filterTableView: UITableView!
    
    var filterViewModel = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ContactConstants.filterTitle
        
        filterTableView.dataSource = self
        filterTableView.delegate = self
        filterTableView.allowsMultipleSelection = true
        
        setupBarButton()
        
        filterViewModel.loadData { [weak self] in
            self?.filterTableView.reloadData()
        }
    }
    
    fileprivate func setupBarButton() {
        let applyBtn = UIBarButtonItem.init(title: "Apply", style: .plain, target: self, action: #selector(applyFilter))
        navigationItem.rightBarButtonItem = applyBtn
        
        let cancelBtn = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(dismissVc))
        navigationItem.leftBarButtonItem = cancelBtn
    }
    
    @objc func applyFilter() {
        filterViewModel.applyFilter { [weak self] (filterData) in
            self?.filterData?.updateData(myData: filterData)
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissVc() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITABLEVIEWDATASOURCE

extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterViewModel.setUpSectionTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section: Section = Section(rawValue: section) else { return 0 }
        
        return filterViewModel.getDatas(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.filterCell, for: indexPath) as? FilterCell else { return UITableViewCell.init() }
        
        guard let section: Section = Section(rawValue: indexPath.section) else {return UITableViewCell.init()}
        
        switch section {
        case .gender:
            cell.gender = filterViewModel.getDatas(section: section)[indexPath.row]
        case .companyName:
            cell.company = filterViewModel.getDatas(section: section)[indexPath.row]
        }
        
        return cell
    }
}

// MARK: - UITABLEVIEWDELEGATE

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ContactConstants.heightForRowatIndexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section: Section = Section(rawValue: indexPath.section) else {return}
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        
        cell.accessoryType = .checkmark
        filterViewModel.appendData(section: section, dataStore: filterViewModel.getDatas(section: section)[indexPath.row], didSelectRow: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let section: Section = Section(rawValue: indexPath.section) else {return}
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        
        cell.accessoryType = .none
        filterViewModel.appendData(section: section, dataStore: filterViewModel.getDatas(section: section)[indexPath.row], didSelectRow: false)
    }
}
