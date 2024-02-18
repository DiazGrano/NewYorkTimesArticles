//
//  NYTimesSplashInteractor.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

class NYTimesSplashInteractor {
    private weak var presenter: NYTimesSplashPresenterProtocol?
    
    func setPresenter(_ presenter: NYTimesSplashPresenterProtocol) {
        self.presenter = presenter
    }
}

extension NYTimesSplashInteractor: NYTimesSplashInteractorProtocol {
    func getArticles() {
        let url = NYTimesURLsHelper.nyTimesWeekMostViewedArticles
        
        NYTimesNetworkManager().request(url: url, method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: true) { [weak self] modelResponse in
            self?.presenter?.responseArticles(data: modelResponse)
        } failure: { [weak self] errorResponse in
            self?.presenter?.responseError(data: errorResponse)
        }

    }
}
