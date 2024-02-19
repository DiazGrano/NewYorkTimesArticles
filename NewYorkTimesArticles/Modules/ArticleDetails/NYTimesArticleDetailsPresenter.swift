//
//  NYTimesArticleDetailsPresenter.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesArticleDetailsPresenter {
    private weak var view: NYTimesArticleDetailsViewControllerProtocol?
    private let interactor: NYTimesArticleDetailsInteractorProtocol
    private let router: NYTimesArticleDetailsRouterProtocol
    private let article: NYTimesArticle
    
    init(interactor: NYTimesArticleDetailsInteractorProtocol, router: NYTimesArticleDetailsRouterProtocol, article: NYTimesArticle) {
        self.interactor = interactor
        self.router = router
        self.article = article
    }
    
    func setView(_ view: NYTimesArticleDetailsViewControllerProtocol) {
        self.view = view
    }
}

extension NYTimesArticleDetailsPresenter: NYTimesArticleDetailsPresenterProtocol {
    func requestArticleImage() {
        guard let nonNilURL = article.getArticleImageURL(format: .large) else {
            return
        }
        interactor.getArticleImage(url: nonNilURL)
    }
    
    func responseArticleImage(image: UIImage?) {
        DispatchQueue.main.async {
            guard let image else {
                return
            }
            
            self.view?.notifyArticleImage(image: image)
        }
    }
    
    func requestArticleData() -> NYTimesArticle {
        return article
    }
}
