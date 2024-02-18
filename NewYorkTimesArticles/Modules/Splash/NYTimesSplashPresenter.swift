//
//  NYTimesSplashPresenter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

class NYTimesSplashPresenter {
    private weak var view: NYTimesSplashViewControllerProtocol?
    private let interactor: NYTimesSplashInteractorProtocol
    private let router: NYTimesSplashRouterProtocol
    
    init(interactor: NYTimesSplashInteractorProtocol, router: NYTimesSplashRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func setView(_ view: NYTimesSplashViewControllerProtocol) {
        self.view = view
    }
}

extension NYTimesSplashPresenter: NYTimesSplashPresenterProtocol {
    func requestArticles() {
        DispatchQueue.main.async {
            self.interactor.getArticles()
        }
    }
    
    func responseArticles(data: NYTimesArticlesResponse) {
        DispatchQueue.main.async {
            guard let articles = data.results, articles.count > 0 else {
                self.view?.notifyError(data: NYTimesErrorModel.getDefaultError(type: .unknown))
                return
            }
            
            self.view?.notifySuccessArticles()
            self.router.navigateToHome(articles: articles)
        }
    }
    
    func responseError(data: NYTimesErrorModel) {
        DispatchQueue.main.async {
            self.view?.notifyError(data: data)
        }
    }
}
