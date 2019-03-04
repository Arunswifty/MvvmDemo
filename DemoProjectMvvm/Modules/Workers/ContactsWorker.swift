//
//  ServiceParser.swift
//  DemoProjectMvvm
//
//  Created by Arun-Swifty on 17/01/19.
//  Copyright © 2019 Arun-Swifty. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class ContactWorker: NSObject {
    
    static func Fetch<T: Codable>(urlStr: String, closureBlock:@escaping(T) -> Void) {
        
        guard let urlStr = URL(string: urlStr) else {return}
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        URLSession.shared.dataTask(with: urlStr) { (dataResponse, _, error) in
            
            guard let data = dataResponse else {return}
            
            DispatchQueue.main.async {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    closureBlock(jsonData)
                } catch {
                    print(error.localizedDescription)
                }
                
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
            }.resume()
    }
}
