//
//  ViewController.swift
//  Players
//
//  Created by Jameel Shehadeh on 21/07/2023.
//

import UIKit

class PlayersListVC: UIViewController , UISearchBarDelegate {

    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.tintColor = AppColors.primary
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavBarAppearance()
        configureNavBar()
    }
    
    func configureNavBar(){
        
        searchBar.delegate = self
        
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

