//
//  UIColor + ext.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat,
                    green: CGFloat,
                    blue: CGFloat) -> UIColor {
        
        return UIColor(red: red / 255,
                       green: green / 255,
                       blue: blue / 255,
                       alpha: 1)
    }
    
    static let vkBlue = UIColor.rgb(red: 92,
                                    green: 128,
                                    blue: 180)
}
