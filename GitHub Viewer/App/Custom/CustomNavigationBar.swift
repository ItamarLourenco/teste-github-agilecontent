//
//  CustomNavigationBar.swift
//  GitHub Viewer
//
//  Created by Itamar Lourenço on 09/06/2018.
//  Copyright © 2018 Ilourenco. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationBar: UINavigationBar {
    var customHeight : CGFloat = 165
    var resize:Bool = false
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!self.resize) {
            return
        }
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
        }
    }
}
