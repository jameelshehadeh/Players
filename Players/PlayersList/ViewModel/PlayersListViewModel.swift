//
//  PlayersListViewModel.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

class PlayersListViewModel  {

    var networkService : Servicing
    
    var players : Observable<[Player]> = Observable(value: [])
    var topPlayers : Observable<[Player]> = Observable(value: [])
    var searchedPlayers : Observable<[Player]> = Observable(value: [])
    var searchedTopPlayers : Observable<[Player]> = Observable(value: [])
    var isSearching : Observable<Bool> = Observable(value: false)
    
    init(networkService: Servicing) {
        self.networkService = networkService
    }
    
    func getPlayersList(){

        networkService.request(endPoint: .getPlayersList, method: .post, body:  nil) { [weak self] (results: Result<PlayersListResponse?,Error> ) in
            guard let self else {return}
            switch results {
                
            case .success(let response):
                guard let players = response?.data else {
                    return
                }
                self.players.value = players
                getTopPlayers(players: self.players.value ?? [])
            case .failure(let error):
                print(error)
            }  
        }
    }
    
    func getTopPlayers(players: [Player]){
        // Getting players with rating more than 60
        topPlayers.value = players.filter({ player in
            guard let playerRate = Double(player.rating) else {return false}
            return playerRate > 60.0
        })
    }
    
    func searchPlayers(text: String){
        guard text.count > 0 else {
            isSearching.value = false
            return
        }
        isSearching.value = true
        searchedPlayers.value = players.value?.filter({ $0.name!.lowercased().contains(text.lowercased()) })
        searchedTopPlayers.value = searchedPlayers.value?.filter({ player in
            guard let playerRate = Double(player.rating) else {return false}
            return playerRate > 60.0
        })
    }
    
}
