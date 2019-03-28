//
//  UIColor+Extention.swift
//  WaveView
//
//  Created by allen_zhang on 2019/3/28.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) {
      
        let read = r/255.0
        let green = g/255.0
        let blue = b/255.0
        self.init(red: read, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) {
        
        let read = r/255.0
        let green = g/255.0
        let blue = b/255.0
        self.init(red: read, green: green, blue: blue, alpha: a)
    }
}
