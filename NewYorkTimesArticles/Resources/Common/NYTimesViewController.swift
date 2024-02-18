//
//  NYTimesViewController.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

open class NYTimesViewController: UIViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func isShowingLoader() -> Bool {
        guard let keyWindow = UIApplication.getKeyWindow() else {
            return false
        }
        
        return keyWindow.subviews.contains(where: { $0 is NYTimesLoaderView })
    }
    
    func showLoader(message: String = "") {
        DispatchQueue.main.async {
            guard !self.isShowingLoader() else {
                return
            }
            
            guard let keyWindow = UIApplication.getKeyWindow() else {
                return
            }
            
            let loader = NYTimesLoaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            keyWindow.addSubview(loader)
            keyWindow.bringSubviewToFront(loader)
            loader.playLoader(message: message)
        }
    }
    
    func hideLoader(completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            guard let loader = UIApplication.getKeyWindow()?.subviews.first(where: { $0 is NYTimesLoaderView }) as? NYTimesLoaderView else {
                return
            }
            
            loader.stopLoader {
                loader.removeFromSuperview()
                completion?()
            }
        }
    }
}
