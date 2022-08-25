//
//  UIImageView+extension.swift
//  SpaceX
//
//  Created by Анна Сычева on 19.08.2022.
//

import UIKit.UIImageView

//MARK: - UIImageView

extension UIImageView {
    
    // MARK: - Public methods
    
    func load(url: URL) {
        DispatchQueue.global().async { [ weak self ] in
            guard
                let self = self,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
