//
//  UIView+AddOn.swift
//  Instagrid
//
//  Created by noje on 17/05/2021.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
