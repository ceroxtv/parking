//
//  ViewController.swift
//  PrpyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 3/5/23.
//

import UIKit
import CoreNFC
import Toast

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate{
    
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
    }
    
    var usuario: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login Parking"
        
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        var mail = mailText.text
        var password = passwordText.text
        
        NetworkingProvider.shared.loginUser(mail: mail ?? "", password: password ?? ""){ (user, error) in
            if let error = error {
                    print("Error fetching car data: \(error)")
                    return
                }
                
                if let user1 = user {
                    DispatchQueue.main.async {
                        self.usuario = user1
                        self.performSegue(withIdentifier: "segueLogin", sender: self.usuario)
                    }
                }
        }
        
        makeToast()
        
    }
    
    @IBAction func actionSign(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueLogin" {
                if let destinoVC = segue.destination as? UserViewController, let user = sender as? User {
                    destinoVC.usuario = user
                }
            }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func makeToast() {
        view.makeToast("Los datos del usuario introducido no son correctos",
                       duration: 2.0,
                       position: .bottom,
                       title: "Usuario Incorrecto")
    }
}

