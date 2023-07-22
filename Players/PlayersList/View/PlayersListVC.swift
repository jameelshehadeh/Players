//
//  ViewController.swift
//  Players
//
//  Created by Jameel Shehadeh on 21/07/2023.
//

import UIKit

class PlayersListVC: UIViewController  {
    
    let viewModel = PlayersListViewModel(networkService: NetworkService())
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.tintColor = AppColors.primary
        searchBar.delegate = self
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    
    private lazy var vStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topPlayersLabel,playersCollectionView,allPlayersLabel,tableContainerView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 12
        stackView.directionalLayoutMargins = .init(top: 24, leading: 20, bottom: 10, trailing: 20)
        stackView.distribution = .fill
        return stackView
    }()
    
    let topPlayersLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = AppColors.primaryMid
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        label.text = "Top Players"
        label.snp.makeConstraints { make in
            make.height.equalTo(29)
        }
        return label
    }()
    
    let allPlayersLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = AppColors.primaryMid
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        label.text = "All Players"
        label.snp.makeConstraints { make in
            make.height.equalTo(29)
        }
        return label
    }()
    
    private lazy var tableContainerView : UIView = {
       let view = UIView()
        view.backgroundColor = AppColors.gary0
        view.layer.borderColor = AppColors.gray01?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
        return view
        
    }()
    
    private lazy var playersCollectionView : UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.sectionInset = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 10)
          layout.minimumInteritemSpacing = 12
          layout.minimumLineSpacing = 10
          layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
          let collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
          collectionView.showsHorizontalScrollIndicator = false
          collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "PlayerCollectionViewCell")
          collectionView.backgroundColor = .clear
          collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
          collectionView.dataSource = self
          collectionView.delegate = self
          collectionView.snp.makeConstraints { make in
            make.height.equalTo(195)
          }
          return collectionView
      }()

    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(PlayerTableViewCell.self
                           , forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNavBarAppearance()
        configureNavBar()
        bindData()
        viewModel.getPlayersList()
    }
    
    
    func bindData(){
        
        viewModel.players.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        viewModel.isSearching.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.playersCollectionView.reloadData()
            }
        }
        
        viewModel.topPlayers.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.playersCollectionView.reloadData()
            }
        }
        
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavBar(){
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action:nil)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = searchBar
        
        searchBar.searchTextField.backgroundColor = .white
        let homeButton = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action:nil)
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "Settings"), style: .plain, target: self, action:nil)
        
        navigationItem.rightBarButtonItems = [homeButton, settingsButton]
        
        let customImageView = UIImageView(image: UIImage(named: "Search"))
        customImageView.contentMode = .scaleAspectFit
        searchBar.searchTextField.rightView = customImageView
        searchBar.searchTextField.rightViewMode = .always
    }

}

extension PlayersListVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else {return}
        viewModel.searchPlayers(text: searchText)
    }
   
}
