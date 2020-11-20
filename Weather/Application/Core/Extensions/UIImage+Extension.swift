//
//  UIImage+Extension.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(with URL: URL) {
        self.kf.setImage(with: URL)
    }
}
