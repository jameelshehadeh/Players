//
//  UIViewController+Extensions.swift
//  Players
//
//  Created by Jameel Shehadeh on 21/07/2023.
//

import UIKit

extension UIViewController {
    
    typealias TitleTextAttributes = [NSAttributedString.Key : Any]
    
    func setNavBarAppearance(bgColor: UIColor = AppColors.primary ?? UIColor.red , titleAtts: TitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]) {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.tintColor = .white
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.titleTextAttributes = titleAtts
        navBarAppearance.largeTitleTextAttributes = titleAtts
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func push(_ vc: UIViewController){
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
