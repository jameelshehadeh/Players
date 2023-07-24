//
//  ViewController.swift
//  Players
//
//  Created by Jameel Shehadeh on 21/07/2023.
//

import UIKit
import JGProgressHUD

class PlayersListVC: UIViewController  {
    
    let viewModel = PlayersListViewModel(networkService: NetworkService())
    let spinner = JGProgressHUD(style: .light)
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.tintColor = AppColors.primary
        searchBar.delegate = self
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    
    private lazy var vStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [topPlayersLabel,searchResultLabel,playersCollectionView,allPlayersLabel,tableContainerView])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 12
        stackView.directionalLayoutMargins = .init(top: 24, leading: 20, bottom: 10, trailing: 20)
        stackView.distribution = .fill
        return stackView
    }()
    
    let searchResultLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        label.textColor = AppColors.primaryMid
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        label.text = "Search results"
        label.snp.makeConstraints { make in
            make.height.equalTo(29)
        }
        return label
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
        
        viewModel.isSearching.bind { [weak self] isSearching in
            guard let self , let isSearching else {return}
            self.configureSearching(isSearching: isSearching)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.playersCollectionView.reloadData()
            }
        }
        
        viewModel.players.bind { [weak self] allPlayers in
            guard let self , let players = allPlayers , !players.isEmpty else {
                return
            }
            DispatchQueue.main.async {
                self.vStackView.isHidden = false
                self.tableView.reloadData()
            }
        }
        
        viewModel.topPlayers.bind { [weak self] topPlayers in
            guard let self, let players = topPlayers , !players.isEmpty else {
                return
            }
            DispatchQueue.main.async {
                self.playersCollectionView.reloadData()
            }
        }
        
        viewModel.showLoader.bind { [weak self] showLoader in
            guard let self , let showLoader else {return}
            DispatchQueue.main.async {
                showLoader ? self.spinner.show(in: self.view) : self.spinner.dismiss()
            }
        }
    
    }
    
    func configureSearching(isSearching: Bool){
        
        if isSearching {
            topPlayersLabel.isHidden = true
            playersCollectionView.isHidden = true
            allPlayersLabel.isHidden = true
            searchResultLabel.isHidden = false
        }
        else {
            topPlayersLabel.isHidden = false
            playersCollectionView.isHidden = false
            allPlayersLabel.isHidden = false
            searchResultLabel.isHidden = true
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
        
        searchBar.searchTextField.backgroundColor = .systemBackground
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
