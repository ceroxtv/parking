//
//  UserViewController.swift
//  ProyectoParking
//
//  Created by Carlos Burguete Herrero (practicas) on 26/5/23.
//

import UIKit
import VisionKit
import Lottie
import Toast

class UserViewController: UIViewController {
    
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var buttonPay: UIButton!
    
    var usuario: User?
    var timer: Timer?
    var elapsedTime: TimeInterval = 0
    
    var scannerAvaliable: Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButoon()
        setupAnimation()
        buttonPay.isEnabled = false
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
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateElapsedTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateElapsedTime() {
        elapsedTime += 1
        print(formatTime(elapsedTime))
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Puedes detener el cronómetro llamando a la función stopTimer()
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    @IBAction func actionPagar(_ sender: Any) {
        stopTimer()
        makeToast()
        scanButton.isEnabled = true
        buttonPay.isEnabled = false
    }
    
    func makeToast() {
        ToastManager.shared.style.backgroundColor = .green
        ToastManager.shared.style.messageColor = .black
        view.makeToast("Precio total -> \(elapsedTime.magnitude/100)€",
                       duration: 2.0,
                       position: .bottom,
                       title: "Elija metodo de pago")
        
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
            buttonPay.isEnabled = true
            scanButton.isEnabled = false
            startTimer()
        default:
            print("Item inesperado")
        }
    }
}
