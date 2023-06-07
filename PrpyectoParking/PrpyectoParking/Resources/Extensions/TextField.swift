//
//  TextField.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 12/5/23.
//

import Foundation
import UIKit

extension UITextField {
    func iconTextField(imageName: String) {
        let iconImage = UIImage(systemName: imageName)
        
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        iconView.image = iconImage
        
        self.borderStyle = .roundedRect
        self.leftView = iconView
        self.leftViewMode = .always
    }
}
