//
//  SignViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 12/5/23.
//

import UIKit
import Toast

class SignViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textFieldDni: UITextField!
    
    @IBOutlet weak var textFieldMail: UITextField!
    
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldSurname: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldDni.iconTextField(imageName: "person.badge.key")
        textFieldMail.iconTextField(imageName: "envelope.badge")
        textFieldName.iconTextField(imageName: "person")
        textFieldPhone.iconTextField(imageName: "phone")
        textFieldSurname.iconTextField(imageName: "person")
        textFieldPassword.iconTextField(imageName: "lock")
        
        textFieldDni.delegate = self
        textFieldMail.delegate = self
        textFieldName.delegate = self
        textFieldPhone.delegate = self
        textFieldSurname.delegate = self
        textFieldPassword.delegate = self
    }
    
    
    @IBAction func actionSign(_ sender: Any) {
        let dni = textFieldDni.text!
        let name = textFieldName.text!
        let surname = textFieldSurname.text!
        let phone = textFieldPhone.text!
        let mail = textFieldMail.text!
        let password = textFieldPassword.text!
        
        if(!validateDNI(dni)) {
            makeToast(mensaje: "El dni es incorrecto")
        }else if(phone.count != 9) {
            makeToast(mensaje: "El telefono debe tener 9 digitos")
        }else if(validateStringNumber(name) || name.count == 0) {
            makeToast(mensaje: "El nombre es incorrecto")
        }else if(validateStringNumber(surname) || surname.count == 0) {
            makeToast(mensaje: "El apellido es incorrecto")
        }else if(!validateMail(mail)) {
            makeToast(mensaje: "El email es incorrecto")
        }else if(password.count == 0) {
            makeToast(mensaje: "La contraseña es incorrecta")
        }else {
            let user = User(dni: dni, mail: mail, password: password, phone: Int(phone)!, name: name, lastName: surname)
            NetworkingProvider.shared.addUser(user: user) { (user, error) in
                if let error = error {
                    // Manejar el error
                    print("Error al añadir el usuario:", error)
                } else if let user = user {
                    // El usuario fue añadido exitosamente
                    print("Usuario añadido:", user)
                }
            }
            makeToast(mensaje: "El usuario se ha creado correctamente")
        }
    }
    
    func validateDNI(_ dni: String) -> Bool {
        let dniRegex = "^\\d{8}[A-HJ-NP-TV-Z]$"
        let dniTest = NSPredicate(format: "SELF MATCHES %@", dniRegex)
        
        if !dniTest.evaluate(with: dni) {
            return false // El formato del DNI no es válido
        }
        
        let dniNumerico = dni.dropLast()
        let letraDNI = String(dni.last!)
        
        let letras = "TRWAGMYFPDXBNJZSQVHLCKE"
        let indice = dniNumerico.reduce(0) { (result, character) in
            result * 10 + Int(String(character))!
        } % 23
        
        let letraCalculada = letras[letras.index(letras.startIndex, offsetBy: indice)]
        
        return letraCalculada == Character(letraDNI)
    }
    
    func validateStringNumber(_ cadena: String) -> Bool {
        let digitCharacterSet = CharacterSet.decimalDigits
        
        let contieneNumeros = cadena.rangeOfCharacter(from: digitCharacterSet) != nil
        
        return contieneNumeros
    }
    
    func validateMail(_ correo: String) -> Bool {
        let correoRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let correoTest = NSPredicate(format: "SELF MATCHES %@", correoRegex)
        return correoTest.evaluate(with: correo)
    }
    
    func makeToast(mensaje: String) {
        view.makeToast(mensaje,
                       duration: 2.0,
                       position: .bottom,
                       title: "Dato Incorrecto")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
