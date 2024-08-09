//
//  Anime.swift
//  GhibliMovies
//
//  Created by Виталий Подшибякин on 12.07.2024.
//

import Foundation

struct Anime: Decodable {
    let title: String?
    let originalTitle: String?
    let image: String?
    let description: String?
    
    init(animeData: [String: Any]) {
        title = animeData["title"] as? String
        originalTitle = animeData["original_title"] as? String
        image = animeData["image"] as? String
        description = animeData["description"] as? String
    }
    
    static func getAnime(from data: Data) -> [Anime] {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else { return [] }
        print(json)
        return json.compactMap { Anime(animeData: $0) }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case image
        case description
    }
}





