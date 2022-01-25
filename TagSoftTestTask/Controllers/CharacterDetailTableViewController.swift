//
//  CharacterDetailsViewController.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

class CharacterDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specyLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    private var charactersManager: CharactersManager?
    private var character: CharacterModel? {
        didSet {
            setupUI()
        }
    }
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersManager = CharactersManager()
        charactersManager?.delegate = self
        if let _id = id {
            charactersManager?.fetchCharactersById(with: _id)
        }
    }
    
    private func setupUI(){
        navigationItem.title = character?.name
        if let url = URL(string: character?.image ?? "") {
           profileImageView.load(url: url)
        }
        statusLabel.text = "Status: \(character?.status ?? "")"
        specyLabel.text = "Specy: \(character?.species ?? "")"
        genderLabel.text = "Gender: \(character?.gender ?? "")"

    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension CharacterDetailTableViewController: CharactersManagerDelegate {
    func didUpdateCharacter(_ characterManager: CharactersManager, character: CharacterModel) {
        DispatchQueue.main.async {
            self.character = character
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

