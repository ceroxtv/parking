//
//  NetworkingProvider.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 12/5/23.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    private let url = "http://192.168.1.230:8080/v1/user"
    private let urlCars = "http://192.168.1.189:3001/api/v1/cars"
    
    func addUser(user: User, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Empty response data", code: 0, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let user = try jsonDecoder.decode(User.self, from: data)
                completion(user, nil)
                
                // Convertir los datos JSON en una cadena de texto
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON recibido:", jsonString)
                } else {
                    print("Error al convertir los datos JSON en una cadena de texto")
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }

    
    func fetchCarData(completion: @escaping ([Car]?, Error?) -> Void) {
        guard let url = URL(string: urlCars) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Empty response data", code: 0, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let cars = try jsonDecoder.decode([Car].self, from: data)
                completion(cars, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    func loginUser(mail: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: "http://192.168.1.230:8080/v1/user/login/?mail=\(mail)&password=\(password)") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "Empty response data", code: 0, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let user = try jsonDecoder.decode(User.self, from: data)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
}
