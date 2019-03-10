//
//  NavigationVc.swift
//  DemoProjectMvvm
//
//  Created by ArunSwifty on 18/01/19.
//  Copyright © 2019 ArunSwifty. All rights reserved.
//

import Foundation
import UIKit

private var mainStoryBoard = "Main"

extension UIViewController {

    static func setupGlobalNavigation(viewController: UIViewController) -> UINavigationController {

        let navigation = UINavigationController.init(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.barTintColor = .black
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.largeTitleTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 35) ?? ""
        ]

        navigation.navigationBar.titleTextAttributes =  [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 25) ?? ""
        ]

        return navigation
    }

    func PresentData<T: UIViewController> (identifier: String?) -> T? {
        
        let viewController = UIStoryboard(name: mainStoryBoard, bundle: nil)
        
        guard let myController = viewController.instantiateViewController(withIdentifier: identifier ?? "") as? T else {
            return nil
       }
        
        return myController
    }

}
