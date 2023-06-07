//
//  UsersDetailViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 26/5/23.
//

import UIKit

class UsersDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelMail: UILabel!
    @IBOutlet weak var labelMatricula: UILabel!
    @IBOutlet weak var labelModelo: UILabel!
    @IBOutlet weak var labelDNI: UILabel!
    @IBOutlet weak var labelContra: UILabel!
    @IBOutlet weak var botonLlamada: UIButton!
    
    var car: Car?
    var indice: Int?
    var imgs = ["user1","user2","user3","user4","user5","user6","user7","user8","user9","user10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imgs[indice ?? 0])?.redondearImagen()
        labelName.text = car?.user.name
        labelMail.text = car?.user.dni
        labelMatricula.text = "Matricula -> \(car?.matricula ?? "")"
        labelModelo.text = "Modelo -> \(car?.modelo ?? "")"
        labelDNI.text = "Email -> \(car?.user.mail ?? "")"
        labelContra.text = "Password -> \(car?.user.password ?? "")"
        botonLlamada.titleLabel?.text = "\(String(describing: car?.user.phone))"
    }
    
    
    @IBAction func actionLlamada(_ sender: Any) {
        if let url = URL(string: "tel://657718108") {
            UIApplication.shared.openURL(url)
        }
    }
    
    

    
}
