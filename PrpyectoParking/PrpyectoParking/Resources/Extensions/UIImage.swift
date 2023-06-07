//
//  UIImage.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 1/6/23.
//

import Foundation
import UIKit

extension UIImage {
    func redondearImagen() -> UIImage? {
        let radio = self.size.width / 2.0
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let contexto = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: self.size), cornerRadius: radio)
        path.addClip()
        
        self.draw(in: CGRect(origin: .zero, size: self.size))
        
        contexto?.drawPath(using: .fillStroke)
        
        let imagenRedondeada = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return imagenRedondeada
    }
}
