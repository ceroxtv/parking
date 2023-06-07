//
//  FirstViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 3/5/23.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var coches: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        setupCollection()
        
        NetworkingProvider.shared.fetchCarData { (cars, error) in
            if let error = error {
                    print("Error fetching car data: \(error)")
                    return
                }
                
                if let cars = cars {
                    self.coches = cars
                    DispatchQueue.main.async {
                            self.collectionView.reloadData() // Actualiza la vista en el hilo principal
                    }
                }
        }
    }
    
    func setupCollection() {
        collectionView.register(UINib(nibName: "CarCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = buildCarCeld(indexPath: indexPath)
        return cell!
    }
    
    func buildCarCeld(indexPath: IndexPath) -> CarCollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarCollectionViewCell
        
        cell?.setShadows()
        cell?.matricula.text = coches[indexPath.row].matricula
        cell?.nombre.text = coches[indexPath.row].user.name
        
        return cell
    }
}

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var car = coches[indexPath.row]
        var controller = UsersDetailViewController()
        controller.car = car
        controller.indice = indexPath.row
        self.present(controller, animated: true)
    }
}
