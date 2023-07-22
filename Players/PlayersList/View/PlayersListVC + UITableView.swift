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
        return viewModel.players.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell ,  let model = viewModel.players.value?[indexPath.row] else {return UITableViewCell()}
        cell.setupCell(model: model)
        return cell
    }
    
}
