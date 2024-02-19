//
//  NYTimesArticleViewCell.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

internal protocol NYTimesArticleViewCellProtocol: AnyObject {
    func articleCellTapped(data: NYTimesArticle)
}

class NYTimesArticleViewCell: UITableViewCell {
    static let identifier = "NYTimesArticleViewCell"
    static let rowHeight: CGFloat = 100
    private var articleData: NYTimesArticle?
    weak var delegate: NYTimesArticleViewCellProtocol?
    private var containerCenterXConstraint = NSLayoutConstraint()
    private let separation = UIScreen.main.bounds.width
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .nyTimesWhite
        return view
    }()
    
    lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var articleImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: NYTimesConstants.images.defaultPhoto)
        imageView.tintColor = .nyTimesBlack
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var articleTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .nyTimesBlack
        label.font = .getGeorgiaFont(14, weight: .bold)
        return label
    }()
    
    private lazy var articlePublisedDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .nyTimesGray
        label.font = .getGeorgiaFont(12, weight: .regular)
        return label
    }()
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NYTimesArticleViewCell {
    private func initComponents() {
        backgroundColor = .clear
        selectionStyle = .none
        setSubviews()
        setAutolayout()
        setTargets()
    }
    
    private func setSubviews() {
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(contentContainer)
        
        contentContainer.addSubview(articleImage)
        contentContainer.addSubview(articleTitleLabel)
        contentContainer.addSubview(articlePublisedDateLabel)
    }
    
    private func setAutolayout() {
        containerCenterXConstraint = contentContainer.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor, constant: separation)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            contentContainer.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            containerCenterXConstraint,
            contentContainer.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            contentContainer.widthAnchor.constraint(equalTo: mainContainerView.widthAnchor),
            
            articleImage.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            articleImage.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            articleImage.widthAnchor.constraint(equalTo: contentContainer.widthAnchor, multiplier: 0.25),
            
            articleTitleLabel.topAnchor.constraint(equalTo: articleImage.topAnchor),
            articleTitleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 20),
            articleTitleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            articleTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: articlePublisedDateLabel.topAnchor, constant: -20),
            
            articlePublisedDateLabel.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            articlePublisedDateLabel.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
            articlePublisedDateLabel.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor)
        ])
    }
    
    private func setTargets() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped))
        gesture.numberOfTapsRequired = 1
        mainContainerView.addGestureRecognizer(gesture)
    }
    
    @objc private func cellTapped() {
        guard let articleData else {
            return
        }
        delegate?.articleCellTapped(data: articleData)
    }
    
    func setCell(article: NYTimesArticle) {
        containerCenterXConstraint.constant = separation
        articleData = article
        articleTitleLabel.text = article.title
        articlePublisedDateLabel.text = article.publishedDate?.toStringDateWithFormat()
        if let url = article.getArticleImageURL(format: .small) {
            NYTimesImagesHelper.shared.getImage(url: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.articleImage.image = image
                }
            }
        } else {
            articleImage.image = UIImage(systemName: NYTimesConstants.images.defaultPhoto)
        }
        animateAppearing()
    }
    
    private func animateAppearing() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.containerCenterXConstraint.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
}
