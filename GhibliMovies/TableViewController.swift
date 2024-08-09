//
//  TableViewController.swift
//  GhibliMovies
//
//  Created by Виталий Подшибякин on 12.07.2024.
//

import UIKit

class TableViewController: UITableViewController {
    private var animes: [Anime] = []
    private var image: [UIImage] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchData(from: Link.ghibliApi.rawValue)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let anime = animes[indexPath.row]
        var content = cell.defaultContentConfiguration()
                
        content.text = anime.title
        content.secondaryText = anime.originalTitle
    //Нет картинок в апи
//        DispatchQueue.global().async {
//            guard let imageData = NetworkManager.shared.fetchImage(from: anime.image) else { return }
//            DispatchQueue.main.async {
//                content.image = UIImage(data: imageData)
//            }
//        }
        

        
        cell.contentConfiguration = content
        return cell
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchAnime(from: url) { animes in
            switch animes {
            case .success(let animes):
                self.animes = animes
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}
