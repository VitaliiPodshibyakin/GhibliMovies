//
//  RandomAnimeViewController.swift
//  GhibliMovies
//
//  Created by Виталий Подшибякин on 16.07.2024.
//

import UIKit

class RandomAnimeViewController: UIViewController {

    private var animes: [Anime] = []
    

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: Link.ghibliApi.rawValue)
    }


    @IBAction func getRandomAnimeButton(_ sender: Any) {
        titleLabel.text = animes.first?.title ?? ""
        animes.shuffle()
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchAnime(from: Link.ghibliApi.rawValue) { result in
            switch result {
            case .success(let animes):
                self.animes = animes
            case .failure(let error):
                print(error)
            }
        }
    }
}
