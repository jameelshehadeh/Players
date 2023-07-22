//
//  NetworkService.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

protocol Servicing {
    
    func request<T: Codable>(endPoint: Endpoint,method : HTTPMethod,body: Data? ,completion: @escaping (Result<T?,Error>)->())
    
}

class NetworkService : Servicing {
    
    func request<T: Codable>(endPoint: Endpoint, method: HTTPMethod = .post, body: Data? = nil, completion: @escaping (Result<T?, Error>) -> ()) {
        
        guard let url = URL(string: endPoint.url) else {
            completion(.failure(NetworkingErrors.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        NSLog("⬜️⬜️ \(url) API call started")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data , response, error in
            guard let data = data else {
                if let error {
                    NSLog("🟥🟥 \(url) API call failed(\(error.localizedDescription)")
                    completion(.failure(error))
                }
                else {
                    completion(.failure(NetworkingErrors.invalidData))
                }
                return
            }

            guard let decodedData = self.decodeJSON(type: T.self,from: data) else {
                NSLog("🟧🟧 \(url) Object decoding failed")
                completion(.failure(NetworkingErrors.failToDecodeJSON))
                return
            }
            completion(.success(decodedData))
            NSLog("🟦🟦 \(url) API response recevied")
                
        }
        
        task.resume()
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print(error)
            return nil
        }
    }
    
}



enum Endpoint : String {
    
    var baseUrl : String {
        return Environment.test.rawValue
    }
  
    var url : String {
        return self.baseUrl + self.rawValue
    }
    
    case getPlayersList = "api/sc/players"
    
}

enum Environment : String {
    
    case test = "https://ios.app99877.com/"
    
}


enum NetworkingErrors : Error {
    case invalidURL
    case badRequest
    case invalidData
    case failToDecodeJSON
    
}


import Foundation

// MARK: - Welcome
struct PlayersListResponse : Codable {
    let status: Int
    let message: String
    let data: [Player]
    let total, perPage: Int

    enum CodingKeys: String, CodingKey {
        case status, message, data, total
        case perPage = "per_page"
    }
}

// MARK: - Datum
struct Player: Codable {
    let id, sportID, slug, name: String
    let nameTranslations: NameTranslations
    let nameShort: String
    let photo: String
    let position: Position
    let positionName: PositionName
    let weight, age, dateBirthAt, height: String
    let shirtNumber: String
    let preferredFoot: PreferredFoot
    let nationalityCode, flag: String
    let marketCurrency: MarketCurrency
    let marketValue, contractUntil, rating: String
    let characteristics: Characteristics?
    let ability: [Ability]?
    let teamID, teamCategoryID, teamVenueID, teamManagerID: String
    let teamSlug, teamName: String
    let teamLogo: String
    let teamNameTranslations: TeamNameTranslations?
    let teamNameShort, teamNameFull, teamNameCode, teamHasSub: String
    let teamGender: TeamGender
    let teamIsNationality, teamCountryCode, teamCountry, teamFlag: String
    let teamFoundation: String
    let updated: Updated

    enum CodingKeys: String, CodingKey {
        case id
        case sportID = "sport_id"
        case slug, name
        case nameTranslations = "name_translations"
        case nameShort = "name_short"
        case photo, position
        case positionName = "position_name"
        case weight, age
        case dateBirthAt = "date_birth_at"
        case height
        case shirtNumber = "shirt_number"
        case preferredFoot = "preferred_foot"
        case nationalityCode = "nationality_code"
        case flag
        case marketCurrency = "market_currency"
        case marketValue = "market_value"
        case contractUntil = "contract_until"
        case rating, characteristics, ability
        case teamID = "team_id"
        case teamCategoryID = "team_category_id"
        case teamVenueID = "team_venue_id"
        case teamManagerID = "team_manager_id"
        case teamSlug = "team_slug"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamNameTranslations = "team_name_translations"
        case teamNameShort = "team_name_short"
        case teamNameFull = "team_name_full"
        case teamNameCode = "team_name_code"
        case teamHasSub = "team_has_sub"
        case teamGender = "team_gender"
        case teamIsNationality = "team_is_nationality"
        case teamCountryCode = "team_country_code"
        case teamCountry = "team_country"
        case teamFlag = "team_flag"
        case teamFoundation = "team_foundation"
        case updated
    }
}

// MARK: - Ability
struct Ability: Codable {
    let name: Name
    let value, fullAverage: Int

    enum CodingKeys: String, CodingKey {
        case name, value
        case fullAverage = "full_average"
    }
}

enum Name: String, Codable {
    case attacking = "Attacking"
    case creativity = "Creativity"
    case defending = "Defending"
    case tactical = "Tactical"
    case technical = "Technical"
}

// MARK: - Characteristics
struct Characteristics: Codable {
    let positive, negative: [Tive]?
}

// MARK: - Tive
struct Tive: Codable {
    let feature: String
    let value: Int
}

enum MarketCurrency: String, Codable {
    case eur = "EUR"
}

// MARK: - NameTranslations
struct NameTranslations: Codable {
    let en: String
}

enum Position: String, Codable {
    case d = "D"
    case f = "F"
    case m = "M"
}

enum PositionName: String, Codable {
    case defender = "Defender"
    case forward = "Forward"
    case midfielder = "Midfielder"
}

enum PreferredFoot: String, Codable {
    case both = "Both"
    case preferredFootLeft = "Left"
    case preferredFootRight = "Right"
}

enum TeamGender: String, Codable {
    case empty = ""
    case m = "M"
}

// MARK: - TeamNameTranslations
struct TeamNameTranslations: Codable {
    let en, ru, de, es: String
    let fr, zh, tr, el: String
    let it: String?
    let nl, pt: String
}

enum Updated: String, Codable {
    case the20221212140731 = "2022-12-12 14:07:31"
}
