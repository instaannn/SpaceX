//
//  UIColor+Extension.swift
//  SpaceX
//
//  Created by Анна Сычева on 25.08.2022.
//

import UIKit.UIColor

// MARK: - UIColor

extension UIColor {
    
    // MARK: - Init
    
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}
