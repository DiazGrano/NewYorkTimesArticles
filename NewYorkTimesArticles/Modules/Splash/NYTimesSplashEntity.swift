//
//  NYTimesSplashEntity.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

struct NYTimesArticlesResponse: Codable {
    let results: [NYTimesArticle]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct NYTimesArticle: Codable {
    let id: Int?
    let publisher: String?
    let publishedDate: String?
    let updatedDate: String?
    let section: String?
    let subsection: String?
    let author: String?
    let title: String?
    let abstract: String?
    let labels: [String]?
    let media: [NYTimesMediaData]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case publisher = "source"
        case publishedDate = "published_date"
        case updatedDate = "updated"
        case section = "section"
        case subsection = "subsection"
        case author = "byline"
        case title = "title"
        case abstract = "abstract"
        case labels = "des_facet"
        case media = "media"
    }
 
    func getArticleImageURL(format: NYTimesImageFormat) -> String? {
        let images = media?.first(where: { $0.type == .image })?.images
        let imageURL = images?.first(where: { $0.format == format })?.url
        return imageURL
    }
    
    func getPublishedAndUpdatedDate() -> String {
        guard let formattedPublishedDate = publishedDate?.toStringDateWithFormat() else {
            return ""
        }
        
        guard let formattedUpdatedDate = updatedDate?.toStringDateWithFormat(), (formattedPublishedDate != formattedUpdatedDate) else {
            return formattedPublishedDate
        }
        
        return "ArticleDetails.message.articleUpdatedDate".localizedFill(formattedPublishedDate, formattedUpdatedDate)
    }
    
    func getFullSection() -> String {
        guard let section else {
            return ""
        }
        
        guard let subsection, !subsection.isEmpty else {
            return section
        }
        
        return "ArticleDetails.message.fullSection".localizedFill(section, subsection)
    }
    
    func getPublisher() -> String {
        guard let publisher else {
            return ""
        }
        return "ArticleDetails.message.publisher".localizedFill(publisher)
    }
}

enum NYTimesMediaType: String, Codable {
    case image = "image"
}

struct NYTimesMediaData: Codable {
    let type: NYTimesMediaType?
    let copyright: String?
    let images: [NYTimesMediaImage]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case copyright = "copyright"
        case images = "media-metadata"
    }
}

enum NYTimesImageFormat: String, Codable {
    case small = "Standard Thumbnail"
    case medium = "mediumThreeByTwo210"
    case large = "mediumThreeByTwo440"
}

struct NYTimesMediaImage: Codable {
    let url: String?
    let format: NYTimesImageFormat?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
    }
}
