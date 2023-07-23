//
//  PlayerDetailsVC.swift
//  Players
//
//  Created by Jameel Shehadeh on 23/07/2023.
//

import UIKit

class PlayerDetailsVC: UIViewController {
    
    private lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.tintColor = AppColors.primary
//        searchBar.delegate = self
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    
    private lazy var vStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [marginView])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 12
        stackView.directionalLayoutMargins = .init(top: 24, leading: 20, bottom: 10, trailing: 20)
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var marginView : UIView = {
       let view = UIView()
        view.backgroundColor = AppColors.primary
        view.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        return view
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
      
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavBar(){
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action:#selector(didtapBack))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = searchBar
        
        searchBar.searchTextField.backgroundColor = .white
        let homeButton = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action:nil)
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "Settings"), style: .plain, target: self, action:nil)
        
        navigationItem.rightBarButtonItems = [homeButton, settingsButton]

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let customImageView = UIImageView(image: UIImage(named: "Search"))
        customImageView.contentMode = .scaleAspectFit
        searchBar.searchTextField.rightView = customImageView
        searchBar.searchTextField.rightViewMode = .always
    }
    
    @objc func didtapBack(){
        navigationController?.popViewController(animated: true)
    }

}
