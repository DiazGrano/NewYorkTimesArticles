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
    
    func responseArticleImage(base64: String?) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let nonNilBase64 = base64, let nonNilData = Data(base64Encoded: nonNilBase64), let nonNilImage = UIImage(data: nonNilData) else {
                return
            }
            
            DispatchQueue.main.async {
                self.view?.notifyArticleImage(image: nonNilImage)
            }
        }
    }
    
    func requestArticleData() -> NYTimesArticle {
        return article
    }
}
