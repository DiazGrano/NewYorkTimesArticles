//
//  NYTimesSplashProtocols.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

protocol NYTimesSplashViewControllerProtocol: AnyObject {
    func notifyError(data: NYTimesErrorModel, localArticlesExists: Bool)
    func notifySuccessArticles()
}

protocol NYTimesSplashInteractorProtocol: AnyObject {
    func getArticles()
}

protocol NYTimesSplashPresenterProtocol: AnyObject {
    func requestArticles()
    func responseArticles(data: NYTimesArticlesResponse)
    func responseError(data: NYTimesErrorModel, localArticles: NYTimesArticlesResponse?)
    func requestHomeWithLocalArticles()
}

protocol NYTimesSplashRouterProtocol: AnyObject {
    func navigateToHome(articles: [NYTimesArticle])
}
