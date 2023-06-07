//
//  TabBarViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 3/5/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        
        tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBar.items?[0].title = "Home"
        
        tabBar.items?[1].image = UIImage(systemName: "exclamationmark.bubble.fill")
        tabBar.items?[1].title = "Incidencias"
    }
 
}
