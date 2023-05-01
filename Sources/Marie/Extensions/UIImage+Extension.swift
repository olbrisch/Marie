//
//  UIImage+Extension.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 20/04/23.
//

import UIKit

extension UIImage {
    
    static var phonewavesIcon: UIImage = (.init(named: "phonewaves") ?? .init(named: "phonewavesPNG") ?? .init())
    static var repeatIcon: UIImage = (.init(named: "repeat") ?? .init(named: "repeatPNG")) ?? .init()
    static var trashIcon: UIImage = (.init(named: "trash") ?? .init(named: "trashPNG")) ?? .init()
    
}
