//
//  NetworkManager.swift
//  GhibliMovies
//
//  Created by Виталий Подшибякин on 16.07.2024.
//

import Foundation
import Alamofire

enum Link: String {
    case ghibliApi = "https://ghibliapi.vercel.app/films"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchAnime(from url: String?, with completion: @escaping(Result<[Anime], NetworkError>) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let anime = try JSONDecoder().decode([Anime].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(anime))
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    func fetchAnimeWithAlamofire(from url: String, completion: @escaping(Result<[Anime], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let response):
                    let animes = Anime.getAnime(from: response)
                    print("Validation Successful")
                    DispatchQueue.main.async {
                        completion(.success(animes))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}

