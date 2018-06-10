//
//  BaseUIViewController.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 09/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
import UIKit

class BaseUIViewController: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets.top = 20
        }
        
        if let customNavigationBar = self.navigationController!.navigationBar as? CustomNavigationBar{
            customNavigationBar.resize = resizeNavigationBar()
            customNavigationBar.layoutSubviews()
        }
    }
    
    func resizeNavigationBar() -> Bool{
        return false
    }
    
}
