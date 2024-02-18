//
//  NYTimesArticleDetailsInteractor.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

class NYTimesArticleDetailsInteractor {
    private weak var presenter: NYTimesArticleDetailsPresenterProtocol?
    
    func setPresenter(_ presenter: NYTimesArticleDetailsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension NYTimesArticleDetailsInteractor: NYTimesArticleDetailsInteractorProtocol {
    func getArticleImage(url: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            // TODO: Load article image and save it or retrieve it from local if exists logic
            guard let nonNilURL = URL(string: url) else {
                return
            }
            let responseData = try? Data(contentsOf: nonNilURL)
            
            guard let nonNilData = responseData else {
                return
            }
            
            let base64Image = nonNilData.base64EncodedString()
            
            self.presenter?.responseArticleImage(base64: base64Image)
        }
    }
}
