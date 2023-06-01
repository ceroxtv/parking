//
//  User.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 12/5/23.
//

import Foundation

struct User: Codable{
    let dni: String
    let mail: String
    let password: String
    let phone: Int
    let name: String
    let lastName: String
}
