//
//  SecondViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 3/5/23.
//

import UIKit
import Toast

class SecondViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Incidencias"
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(gesture)
        setupCollection()
        rellenaIncidencias()
    }
    
    func setupCollection() {
        collectionView.register(UINib(nibName: "IncidenciaCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "cell2")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 85) //
    }
    
    func makeToast(mensaje: String, abrir: Bool) {
        if abrir {
            ToastManager.shared.style.backgroundColor = .green
            ToastManager.shared.style.messageColor = .black
            view.makeToast(mensaje,
                           duration: 2.0,
                           position: .bottom,
                           title: "Abriendo Puerta")
        }else {
            ToastManager.shared.style.backgroundColor = .red
            ToastManager.shared.style.messageColor = .black
            view.makeToast(mensaje,
                           duration: 2.0,
                           position: .bottom,
                           title: "Cerrando Puerta")
        }
    }
    
    func rellenaIncidencias() {
        var array: [String] = []
        for index in 0...Int(arc4random_uniform(UInt32(8))) {
            array.append("\(index)")
        }
        
        data = array
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        
        if gestureRecognizer.state == .ended {
            rellenaIncidencias()
            collectionView.reloadData()
        }
    }
}

extension SecondViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = buildCarCeld(indexPath: indexPath)
        
        cell?.checkButtonAction = {
            self.data.remove(at: indexPath.row)
            collectionView.reloadData()
            self.makeToast(mensaje: "La puerta se ha abierto con exito", abrir: true)
        }
        
        cell?.crossButtonAction = {
            self.data.remove(at: indexPath.row)
            collectionView.reloadData()
            self.makeToast(mensaje: "La puerta no ha sido abierta", abrir: false)
        }
        
        return cell!
    }
    
    func buildCarCeld(indexPath: IndexPath) -> IncidenciaCollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? IncidenciaCollectionViewCell
        
        cell?.setShadows()
        
        return cell
    }
}


