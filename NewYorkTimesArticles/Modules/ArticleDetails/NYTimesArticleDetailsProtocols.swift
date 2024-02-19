//
//  NYTimesArticleDetailsProtocols.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

protocol NYTimesArticleDetailsViewControllerProtocol: AnyObject {
    func notifyArticleImage(image: UIImage)
}

protocol NYTimesArticleDetailsInteractorProtocol: AnyObject {
    func getArticleImage(url: String)
}

protocol NYTimesArticleDetailsPresenterProtocol: AnyObject {
    func requestArticleImage()
    func responseArticleImage(image: UIImage?)
    func requestArticleData() -> NYTimesArticle
}

protocol NYTimesArticleDetailsRouterProtocol: AnyObject {
    
}
