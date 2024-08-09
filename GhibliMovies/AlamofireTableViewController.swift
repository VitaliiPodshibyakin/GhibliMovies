//
//  AlamofireTableViewController.swift
//  GhibliMovies
//
//  Created by Виталий Подшибякин on 18.07.2024.
//

import UIKit
import Alamofire

class AlamofireTableViewController: UIViewController {

    private var animes: [Anime] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnimeWithAlamofire()
    }
}

// MARK: - Table view data source

extension AlamofireTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alCell", for: indexPath)
        let anime = animes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = anime.title
        content.secondaryText = anime.originalTitle
        cell.contentConfiguration = content
        return cell
    }

    
}
// MARK: - Networking
extension AlamofireTableViewController {
    private func fetchAnimeWithAlamofire() {
        NetworkManager.shared.fetchAnimeWithAlamofire(from: Link.ghibliApi.rawValue) { result in
            switch result {
            case .success(let animes):
                self.animes = animes
                print(self.animes)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

