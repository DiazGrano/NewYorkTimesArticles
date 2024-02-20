//
//  NYTimesArticleDetailsInteractor.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

class NYTimesArticleDetailsInteractor {
    private(set) weak var presenter: NYTimesArticleDetailsPresenterProtocol?
    
    func setPresenter(_ presenter: NYTimesArticleDetailsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension NYTimesArticleDetailsInteractor: NYTimesArticleDetailsInteractorProtocol {
    func getArticleImage(url: String) {
        NYTimesImagesHelper.shared.getImage(url: url) { [weak self] image in
            self?.presenter?.responseArticleImage(image: image)
        }
    }
}
