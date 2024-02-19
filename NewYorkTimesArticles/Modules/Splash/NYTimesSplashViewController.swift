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
        view.backgroundColor = .nyTimesWhite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticles()
    }
    
    func loadArticles() {
        showLoader(message: "Splash.message.loading".localized)
        presenter.requestArticles()
    }
}

extension NYTimesSplashViewController: NYTimesSplashViewControllerProtocol {
    func notifyError(data: NYTimesErrorModel, localArticlesExists: Bool) {
        hideLoader()
        
        let alert = UIAlertController(title: data.title, message: data.getFormattedMessage(), preferredStyle: .alert)
        
        if localArticlesExists {
            let useLocalArticlesAction = UIAlertAction(title: "Alerts.action.useLocalArticles".localized, style: .default) { [weak self] _ in
                self?.presenter.requestHomeWithLocalArticles()
            }
            alert.addAction(useLocalArticlesAction)
        }
        
        let retryAction = UIAlertAction(title: "Alerts.action.retry".localized, style: .default) { [weak self] _ in
            self?.loadArticles()
        }
        alert.addAction(retryAction)
        
        self.present(alert, animated: true)
    }
    
    func notifySuccessArticles() {
        hideLoader()
    }
}
