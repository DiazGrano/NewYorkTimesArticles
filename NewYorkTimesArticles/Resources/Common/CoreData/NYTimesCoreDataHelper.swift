//
//  CoreDataHelper.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 18/02/24.
//

import UIKit
import CoreData

class NYTimesCoreDataHelper {
    static let shared = NYTimesCoreDataHelper()
    private var context: NSManagedObjectContext?
    
    private init() {
        DispatchQueue.main.async {
            self.context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        }
    }

    private func deleteArticles(completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            let request = NSBatchDeleteRequest(fetchRequest: NYTimesArticleItem.fetchRequest())
            _ = try? self.context?.execute(request)
            try? self.context?.save()
            completion?()
        }
    }
    
    func saveArticles(model: NYTimesArticlesResponse, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            guard let context = self.context else {
                completion?()
                return
            }
            
            self.deleteArticles { [weak self] in
                let jsonArticle = self?.parseArticleModelToJson(model: model)
                let articleItem = NYTimesArticleItem(context: context)
                articleItem.results = jsonArticle
                try? context.save()
                completion?()
            }
        }
    }
    
    func getArticles(completion: @escaping ((NYTimesArticlesResponse?) -> ()))  {
        DispatchQueue.main.async {
            guard let articlesItem = try? self.context?.fetch(NYTimesArticleItem.fetchRequest()).first, let articlesResult = articlesItem.results else {
                return
            }
            
            let articlesModel = self.parseArticleJsonToModel(json: articlesResult)
            
            completion(articlesModel)
        }
    }
    
    func getBase64ImageByURL(url: String, completion: @escaping ((String?) -> ())) {
        DispatchQueue.main.async {
            guard let context = self.context else {
                completion(nil)
                return
            }
            
            let fetchRequest = ImageItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "url == %@", url)
            
            guard let imageItem = try? context.fetch(fetchRequest).first, let base64Image = imageItem.imageData else {
                completion(nil)
                return
            }
            
            completion(base64Image)
        }
    }
    
    func saveBase64ImageByURL(url: String, image: String, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            guard let context = self.context else {
                completion?()
                return
            }
            let imageItem = ImageItem(context: context)
            imageItem.url = url
            imageItem.imageData = image
            try? context.save()
            completion?()
        }
    }
    
    private func parseArticleModelToJson(model: Codable) -> String? {
        guard let jsonData = try? JSONEncoder().encode(model), let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        
        return jsonString
    }
    
    private func parseArticleJsonToModel(json: String) -> NYTimesArticlesResponse? {
        guard let jsonData = json.data(using: .utf8), let model = try? JSONDecoder().decode(NYTimesArticlesResponse.self, from: jsonData) else {
            return nil
        }
        
        return model
    }
}
