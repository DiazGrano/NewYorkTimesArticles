//
//  NYTimesHomeInteractor.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

class NYTimesHomeInteractor {
    private(set) weak var presenter: NYTimesHomePresenterProtocol?
    
    func setPresenter(_ presenter: NYTimesHomePresenterProtocol) {
        self.presenter = presenter
    }
}

extension NYTimesHomeInteractor: NYTimesHomeInteractorProtocol {
    
}
