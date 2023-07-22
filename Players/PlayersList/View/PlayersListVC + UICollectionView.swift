//
//  PlayersListVC + UICollectionView.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import UIKit

extension PlayersListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.isSearching.value == true ?
        (viewModel.searchedTopPlayers.value?.count ?? 0) :
            (viewModel.topPlayers.value?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as? PlayerCollectionViewCell else {return UICollectionViewCell()}
        var cellModel : Player?
        viewModel.isSearching.value == true ?
            (cellModel = viewModel.searchedTopPlayers.value?[indexPath.row]) : (cellModel = viewModel.topPlayers.value?[indexPath.row])
        guard let model = cellModel else {return UICollectionViewCell()}
        
        cell.setupCell(model: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 136, height: 186)
    }
}
