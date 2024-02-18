//
//  NYTimesHomePresenter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

class NYTimesHomePresenter {
    private weak var view: NYTimesHomeViewControllerProtocol?
    private let interactor: NYTimesHomeInteractorProtocol
    private let router: NYTimesHomeRouterProtocol
    private let articles: [NYTimesArticle]
    
    init(interactor: NYTimesHomeInteractorProtocol, router: NYTimesHomeRouterProtocol, articles: [NYTimesArticle]) {
        self.interactor = interactor
        self.router = router
        self.articles = articles
    }
    
    func setView(_ view: NYTimesHomeViewControllerProtocol) {
        self.view = view
    }
}

extension NYTimesHomePresenter: NYTimesHomePresenterProtocol {
    func requestArticles() -> [NYTimesArticle] {
        return articles
    }
    
    func requestArticleDetails(article: NYTimesArticle) {
        router.navigateToArticleDetails(article: article)
    }
}
