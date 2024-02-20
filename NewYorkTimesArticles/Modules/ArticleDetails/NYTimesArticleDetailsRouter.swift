//
//  NYTimesArticleDetailsRouter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesArticleDetailsRouter {
    private(set) var navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start(article: NYTimesArticle) {
        DispatchQueue.main.async {
            let interactor = NYTimesArticleDetailsInteractor()
            let presenter = NYTimesArticleDetailsPresenter(interactor: interactor, router: self, article: article)
            let view = NYTimesArticleDetailsViewController(presenter: presenter)
            
            presenter.setView(view)
            interactor.setPresenter(presenter)
            
            self.present(view)
        }
    }
    
    private func present(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.present(viewController, animated: animated)
    }
}

extension NYTimesArticleDetailsRouter: NYTimesArticleDetailsRouterProtocol {
    
}
