//
//  NYTimesArticleDetailsViewController.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesArticleDetailsViewController: NYTimesViewController {
    private let presenter: NYTimesArticleDetailsPresenterProtocol
    
    private lazy var titleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: NYTimesConstants.images.nyTimesTitleLogo)
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .nyTimesBlack
        return view
    }()
    
    private lazy var containerScroll: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var articleSectionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .nyTimesGray
        label.font = .getGeorgiaFont(12, weight: .bold)
        label.text = presenter.requestArticleData().getFullSection()
        return label
    }()
    
    private lazy var articleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: NYTimesConstants.images.defaultPhoto)
        imageView.tintColor = .nyTimesBlack
        return imageView
    }()

    private lazy var articleTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .nyTimesBlack
        label.font = .getGeorgiaFont(22, weight: .bold)
        label.text = presenter.requestArticleData().title
        return label
    }()
    
    private lazy var articleAuthorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .nyTimesBlack
        label.font = .getGeorgiaFont(12, weight: .bold)
        label.text = presenter.requestArticleData().author
        return label
    }()
    
    private lazy var articlePublishedDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .nyTimesGray
        label.font = .getGeorgiaFont(12, weight: .regular)
        label.text = presenter.requestArticleData().getPublishedAndUpdatedDate()
        return label
    }()
    
    private lazy var articleAbstractLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .nyTimesBlack
        label.font = .getGeorgiaFont(18, weight: .regular)
        label.text = presenter.requestArticleData().abstract
        return label
    }()
    
    private lazy var articlePublisherLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .nyTimesGray
        label.font = .getGeorgiaFont(12, weight: .regular)
        label.text = presenter.requestArticleData().getPublisher()
        return label
    }()
    
    required init(presenter: NYTimesArticleDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestArticleImage()
    }
}

extension NYTimesArticleDetailsViewController {
    func initComponents() {
        view.backgroundColor = .nyTimesWhite
        setSubviews()
        setAutolayout()
    }
    
    func setSubviews(){
        view.addSubview(titleImageView)
        view.addSubview(separatorView)
        view.addSubview(containerScroll)
        
        containerScroll.addSubview(mainContainerView)
        
        mainContainerView.addSubview(articleSectionLabel)
        mainContainerView.addSubview(articleImageView)
        mainContainerView.addSubview(articleTitleLabel)
        mainContainerView.addSubview(articlePublishedDateLabel)
        mainContainerView.addSubview(articleAuthorLabel)
        mainContainerView.addSubview(articleAbstractLabel)
        mainContainerView.addSubview(articlePublisherLabel)
        
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleImageView.heightAnchor.constraint(equalToConstant: 25),
            
            separatorView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: titleImageView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            containerScroll.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            containerScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainContainerView.topAnchor.constraint(equalTo: containerScroll.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: containerScroll.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: containerScroll.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: containerScroll.bottomAnchor),
            mainContainerView.widthAnchor.constraint(equalTo: containerScroll.widthAnchor),
            mainContainerView.heightAnchor.constraint(greaterThanOrEqualTo: containerScroll.heightAnchor),
            
            articleSectionLabel.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 20),
            articleSectionLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articleSectionLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            articleImageView.topAnchor.constraint(equalTo: articleSectionLabel.bottomAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            articleTitleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
            articleTitleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articleTitleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            articleAuthorLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 10),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            articlePublishedDateLabel.topAnchor.constraint(equalTo: articleAuthorLabel.bottomAnchor, constant: 0),
            articlePublishedDateLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articlePublishedDateLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            articleAbstractLabel.topAnchor.constraint(equalTo: articlePublishedDateLabel.bottomAnchor, constant: 40),
            articleAbstractLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articleAbstractLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            articleAbstractLabel.bottomAnchor.constraint(lessThanOrEqualTo: articlePublisherLabel.topAnchor, constant: -20),
            
            articlePublisherLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            articlePublisherLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            articlePublisherLabel.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -20),
        ])
    }
}

extension NYTimesArticleDetailsViewController: NYTimesArticleDetailsViewControllerProtocol {
    func notifyArticleImage(image: UIImage) {
        articleImageView.image = image
    }
}
