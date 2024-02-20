//
//  NYTimesSplashRouter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

class NYTimesSplashRouter {
    private(set) var navigation: UINavigationController?
    
    public func start() -> UIViewController {
        let interactor = NYTimesSplashInteractor()
        let presenter = NYTimesSplashPresenter(interactor: interactor, router: self)
        let view = NYTimesSplashViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        return view
    }
    
    func setNavigation(_ navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension NYTimesSplashRouter: NYTimesSplashRouterProtocol {
    func navigateToHome(articles: [NYTimesArticle]) {
        guard let navigation else {
            return
        }
        NYTimesHomeRouter(navigation: navigation).start(articles: articles)
    }
}
