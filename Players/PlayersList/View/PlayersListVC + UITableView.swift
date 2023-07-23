//
//  PlayersListVC + UITableView.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import UIKit

extension PlayersListVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.isSearching.value == true ?
        (viewModel.searchedPlayers.value?.count ?? 0) :
            (viewModel.players.value?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayerDetailsVC()
        push(vc)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell else {return UITableViewCell()}
        var cellModel : Player?
        viewModel.isSearching.value == true ?
            (cellModel = viewModel.searchedPlayers.value?[indexPath.row]) : (cellModel = viewModel.players.value?[indexPath.row])
        guard let model = cellModel else {return UITableViewCell()}
        cell.setupCell(model: model)
        return cell
    }
    
}
