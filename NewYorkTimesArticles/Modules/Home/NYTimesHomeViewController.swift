//
//  NYTimesHomeViewController.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import UIKit

class NYTimesHomeViewController: NYTimesViewController {
    private let presenter: NYTimesHomePresenterProtocol
    
    private lazy var mainContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private lazy var mostViewedFactsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .nyTimesBlack
        label.font = .getGeorgiaFont(18, weight: .bold)
        label.text = "Home.message.mostViewed".localized
        return label
    }()
    
    lazy var mostViewedFactsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(NYTimesArticleViewCell.self, forCellReuseIdentifier: NYTimesArticleViewCell.identifier)
        table.rowHeight = NYTimesArticleViewCell.rowHeight
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.contentInset.bottom = 40
        return table
    }()
    
    required init(presenter: NYTimesHomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension NYTimesHomeViewController {
    func initComponents() {
        view.backgroundColor = .white
        setSubviews()
        setAutolayout()
    }
    
    func setSubviews(){
        view.addSubview(mainContainerView)
        mainContainerView.addSubview(titleImageView)
        mainContainerView.addSubview(separatorView)
        mainContainerView.addSubview(mostViewedFactsLabel)
        mainContainerView.addSubview(mostViewedFactsTable)
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            titleImageView.heightAnchor.constraint(equalToConstant: 40),
            
            separatorView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            mostViewedFactsLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            mostViewedFactsLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            mostViewedFactsLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            mostViewedFactsTable.topAnchor.constraint(equalTo: mostViewedFactsLabel.bottomAnchor, constant: 10),
            mostViewedFactsTable.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            mostViewedFactsTable.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            mostViewedFactsTable.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
        ])
    }
}

extension NYTimesHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.requestArticles().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articles = presenter.requestArticles()
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTimesArticleViewCell.identifier, for: indexPath) as? NYTimesArticleViewCell
        
        guard let nonNilCell = cell, articles.count > indexPath.row else {
            return UITableViewCell()
        }
        nonNilCell.setCell(article: articles[indexPath.row])
        nonNilCell.delegate = self

        return nonNilCell
    }
}

extension NYTimesHomeViewController: NYTimesArticleViewCellProtocol {
    func articleCellTapped(data: NYTimesArticle) {
        presenter.requestArticleDetails(article: data)
    }
}

extension NYTimesHomeViewController: NYTimesHomeViewControllerProtocol {
    
}

