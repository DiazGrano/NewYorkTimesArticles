//
//  NYTimesSplashViewController.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

class NYTimesSplashViewController: NYTimesViewController {
    private let presenter: NYTimesSplashPresenterProtocol
    
    required init(presenter: NYTimesSplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func initComponents() {
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader(message: "Splash.message.loading".localized)
        presenter.requestArticles()
    }
}

extension NYTimesSplashViewController: NYTimesSplashViewControllerProtocol {
    func notifyError(data: NYTimesErrorModel) {
        print(data.getFormattedMessage())
    }
    func notifySuccessArticles() {
        hideLoader()
    }
}
