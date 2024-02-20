//
//  NYTimesImagesHelper.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 18/02/24.
//

import UIKit

class NYTimesImagesHelper {
    static let shared = NYTimesImagesHelper()
    var coreDataHelper = NYTimesCoreDataHelper()
    
    func getImage(url: String, completion: @escaping ((UIImage?) -> ())) {
        getBase64Image(url: url) { base64Image in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let nonNilBase64 = base64Image, let nonNilData = Data(base64Encoded: nonNilBase64), let nonNilImage = UIImage(data: nonNilData) else {
                    completion(nil)
                    return
                }
                
                completion(nonNilImage)
            }
        }
    }
    
    private func getBase64Image(url: String, completion: @escaping ((String?) -> ())) {
        coreDataHelper.getBase64ImageByURL(url: url) { [weak self] localBase64Image in
            guard let localBase64Image else {
                self?.downloadBase64Image(url: url, completion: completion)
                return
            }
            
            completion(localBase64Image)
        }
    }
    
    private func downloadBase64Image(url: String, completion: @escaping ((String?) -> ())) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let nonNilURL = URL(string: url) else {
                completion(nil)
                return
            }
            let responseData = try? Data(contentsOf: nonNilURL)
            
            guard let nonNilData = responseData else {
                completion(nil)
                return
            }
            
            let base64Image = nonNilData.base64EncodedString()
            
            self.coreDataHelper.saveBase64ImageByURL(url: url, image: base64Image) {
                completion(base64Image)
            }
        }
    }
}
