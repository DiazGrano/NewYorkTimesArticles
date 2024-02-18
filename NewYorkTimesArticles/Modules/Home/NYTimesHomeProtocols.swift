//
//  NYTimesHomeProtocols.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

protocol NYTimesHomeViewControllerProtocol: AnyObject {
    
}

protocol NYTimesHomeInteractorProtocol: AnyObject {
    
}

protocol NYTimesHomePresenterProtocol: AnyObject {
    func requestArticles() -> [NYTimesArticle]
    func requestArticleDetails(article: NYTimesArticle)
}

protocol NYTimesHomeRouterProtocol: AnyObject {
    func navigateToArticleDetails(article: NYTimesArticle) 
}
