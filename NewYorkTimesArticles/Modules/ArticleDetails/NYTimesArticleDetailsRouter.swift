//
//  NYTimesArticleDetailsRouter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesArticleDetailsRouter {
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start(article: NYTimesArticle) {
        let interactor = NYTimesArticleDetailsInteractor()
        let presenter = NYTimesArticleDetailsPresenter(interactor: interactor, router: self, article: article)
        let view = NYTimesArticleDetailsViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        present(view)
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
    
    private func present(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.present(viewController, animated: animated)
    }
}

extension NYTimesArticleDetailsRouter: NYTimesArticleDetailsRouterProtocol {
    
}
