//
//  NYTimesSplashInteractor.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

class NYTimesSplashInteractor {
    private weak var presenter: NYTimesSplashPresenterProtocol?
    var networkManager = NYTimesNetworkManager()
    var coreDataHelper = NYTimesCoreDataHelper()
    
    func setPresenter(_ presenter: NYTimesSplashPresenterProtocol) {
        self.presenter = presenter
    }
    
    func saveArticlesToLocal(modelResponse: NYTimesArticlesResponse){
        DispatchQueue.main.async {
            self.coreDataHelper.saveArticles(model: modelResponse) { [weak self] in
                self?.presenter?.responseArticles(data: modelResponse)
            }
        }
    }
    
    func searchForLocalArticles(errorResponse: NYTimesErrorModel) {
        DispatchQueue.main.async {
            self.coreDataHelper.getArticles { [weak self] articlesResponse in
                self?.presenter?.responseError(data: errorResponse, localArticles: articlesResponse)
            }
        }
    }
}

extension NYTimesSplashInteractor: NYTimesSplashInteractorProtocol {    
    func getArticles() {
        let url = NYTimesURLsHelper.nyTimesWeekMostViewedArticles
        
        networkManager.request(url: url, method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: true) { [weak self] modelResponse in
            self?.saveArticlesToLocal(modelResponse: modelResponse)
        } failure: { [weak self] errorResponse in
            self?.searchForLocalArticles(errorResponse: errorResponse)
        }
    }
}
