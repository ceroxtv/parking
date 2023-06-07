//
//  IncidenciaCollectionViewCell.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 24/5/23.
//

import UIKit

class IncidenciaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    var checkButtonAction: (() -> Void)?
    var crossButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView1.image = UIImage(systemName: "checkmark.seal.fill")
        imageView1.tintColor = .green
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( checkPressed)))
        
        imageView2.image = UIImage(systemName: "xmark.seal.fill")
        imageView2.tintColor = .red
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( crossPressed)))

    }
    
    @objc func checkPressed() {
        checkButtonAction?()
    }
    
    @objc func crossPressed() {
        crossButtonAction?()
    }
    
    

}
