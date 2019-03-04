//
//  ViewController.swift
//  DemoProjectMvvm
//
//  Created by Arun-Swifty on 17/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import UIKit
import RealmSwift
import Realm 

class ContactViewController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var peopleTable: UITableView!
    var viewContactModel = ContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ContactConstants.vcTitle
        
        let loadNib = UINib.init(nibName: CellIdentifier.contactCell, bundle: nil)
        peopleTable.register(loadNib, forCellReuseIdentifier: CellIdentifier.contactCell)
        
        setupBarButton()
        
        viewContactModel.delegate = self
        
        viewContactModel.dataParsing { [weak self] (_) in
            self?.peopleTable.dataSource = self
            self?.peopleTable.delegate = self
            self?.peopleTable.estimatedRowHeight = 120
            self?.peopleTable.reloadData()
        }
    }
    
    /**
     Settingup barbutton
     **/
    
    fileprivate func setupBarButton() {
        let imgData = UIImage.init(named: ContactConstants.filterImg)
        let reloadData = UIImage.init(named: ContactConstants.reloadImg)
        
        let filterBtn = UIBarButtonItem.init(image: imgData, style: .plain, target: self, action: #selector(self.filterVc))
        filterBtn.tintColor = UIColor.white
        
        let reloadBtn = UIBarButtonItem.init(image: reloadData, style: .plain, target: self, action: #selector(self.reload))
        reloadBtn.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItems = [filterBtn, reloadBtn]
    }
    
    @objc func reload() {
        
        viewContactModel.deleteAll()
        
        viewContactModel.dataParsing { [weak self] (_) in
            self?.peopleTable.reloadData()
        }
    }
    
    @objc func filterVc() {
        let myDataVc = PresentData(identifier: StoryboardIdentifier.filterData) as? FilterViewController
        myDataVc?.filterData = self
        guard let filterController = myDataVc else { return }
        let navigation = UINavigationController.setupGlobalNavigation(viewController: filterController)
        present(navigation, animated: true, completion: nil)
    }
}

// MARK: DataBinding Delegate

extension ContactViewController: FilterProtocol {
    func updateData(myData: Results<StoreContact>) {
        viewContactModel.filteredData(myData: myData) { [weak self] in
            self?.peopleTable.reloadData()
        }
    }
}

extension ContactViewController: ContactViewModelProtocol {
    func dataLoading() {
        activityView.startAnimating()
    }
    
    func stopLoading() {
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}

extension ContactViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewContactModel.numberOfContacts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataCell: ContactCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.contactCell, for: indexPath) as? ContactCell else {
            return UITableViewCell.init()
        }
        
        dataCell.dataModel = viewContactModel.setContact(at: indexPath.row)
        return dataCell
    }
}

extension ContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myDataVc = self.PresentData(identifier: StoryboardIdentifier.detailVc) as? DetailViewController
        guard let detailVc = myDataVc else { return }
        myDataVc?.detailData = viewContactModel.setContact(at: indexPath.row)
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {return}
        
        viewContactModel.deleteSelectedRows(index: indexPath, storeData: viewContactModel.setContact(at: indexPath.row)) { [weak self] in
            self?.peopleTable.reloadData()
        }
    }
}
