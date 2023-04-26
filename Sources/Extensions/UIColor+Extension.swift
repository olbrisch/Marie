//
//  UIColor+Extension.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 15/04/23.
//

import UIKit

extension UIColor {
    
    static var backgroudColor: UIColor = {
        .init(named: "BackgroudColor") ?? .init()
    }()
    
    static var primaryTextColor: UIColor = {
        .init(named: "PrimaryTextColor") ?? .init()
    }()
    
    static var secondaryTextColor: UIColor = {
        .init(named: "SecondaryTextColor") ?? .init()
    }()
    
    static var JSONKeyColor: UIColor = {
        .init(named: "JSONKeyColor") ?? .init()
    }()
    
    static var JSONNumbersValueColor: UIColor = {
        .init(named: "JSONNumbersValueColor") ?? .init()
    }()
    
    static var JSONOtherValuesColor: UIColor = {
        .init(named: "JSONOtherValuesColor") ?? .init()
    }()
    
    static var JSONStringValueColor: UIColor = {
        .init(named: "JSONStringValueColor") ?? .init()
    }()
    
    static var invertedPrimaryTextColor: UIColor = {
        .init(named: "InvertedPrimaryTextColor") ?? .init()
    }()
    
    static var invertedSecondaryTextColor: UIColor = {
        .init(named: "InvertedSecondaryTextColor") ?? .init()
    }()
    
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
