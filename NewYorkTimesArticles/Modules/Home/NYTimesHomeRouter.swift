//
//  NYTimesHomeRouter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesHomeRouter {
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start(articles: [NYTimesArticle]) {
        let interactor = NYTimesHomeInteractor()
        let presenter = NYTimesHomePresenter(interactor: interactor, router: self, articles: articles)
        let view = NYTimesHomeViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        push(view)
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
}

extension NYTimesHomeRouter: NYTimesHomeRouterProtocol {
    func navigateToArticleDetails(article: NYTimesArticle) {
        NYTimesArticleDetailsRouter(navigation: navigation).start(article: article)
    }
}
