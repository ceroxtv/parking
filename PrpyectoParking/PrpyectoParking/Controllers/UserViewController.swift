//
//  UserViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 26/5/23.
//

import UIKit
import VisionKit
import Lottie

class UserViewController: UIViewController {
    
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var animationView: UIView!
    
    var usuario: User?
    
    var scannerAvaliable: Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButoon()
        setupAnimation()
        print(usuario)
        
    }
    
    func setupAnimation() {
        let animatedView = LottieAnimationView(name: "qr_animation")
        animatedView.isUserInteractionEnabled = false
        animatedView.frame = CGRect(x: -50, y: 50, width: 500, height: 500)
        view.addSubview(animatedView)
        animatedView.loopMode = .loop
        animatedView.play()
    }
    
    func setupButoon() {
        let button = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(openProfileView))
        button.image = UIImage(systemName: "person.fill")
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func openProfileView() {
        performSegue(withIdentifier: "profile_user", sender: self)
    }
    
    
    @IBAction func actionScann(_ sender: Any) {
        guard scannerAvaliable == true else {
            print("❌ Error no esta permitido scannear")
            return
        }
        
        let dataScanner = DataScannerViewController(recognizedDataTypes: [.text(), .barcode()], isHighlightingEnabled: true)
        dataScanner.delegate = self
        present(dataScanner, animated: true) {
            try? dataScanner.startScanning()
        }
    }
    
}

extension UserViewController: DataScannerViewControllerDelegate {
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .text(let text):
            print("Text: \(text.transcript)")
            UIPasteboard.general.string = text.transcript
        case .barcode(let code):
            guard let urlString = code.payloadStringValue else { return }
            guard let url = URL(string: urlString) else { return }
            //UIApplication.shared.open(url)
            dismiss(animated: true)
            view.subviews.last?.isHidden = true
        default:
            print("Item inesperado")
        }
    }
}
