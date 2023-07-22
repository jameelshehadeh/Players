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
            case .failure(let error):
                print(error)
            }  
        }
    }
    
    
}