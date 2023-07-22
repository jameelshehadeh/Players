//
//  PlayersListResponse.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

// MARK: - PlayersListResponse
struct PlayersListResponse : Codable {
    let status: Int?
    let message: String?
    let data: [Player]?
    let total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case status, message, data, total
        case perPage = "per_page"
    }
}
