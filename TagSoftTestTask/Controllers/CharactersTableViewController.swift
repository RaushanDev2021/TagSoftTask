//
//  TableViewController.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    private var charactersManager: CharactersManager?
    
    private var characters: [CharacterModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        charactersManager = CharactersManager()
        charactersManager?.delegate = self
        registerTableViewCell()
        charactersManager?.fetchCharacters()
    }
    
    @IBAction func sortBarButtonDidPress(_ sender: UIBarButtonItem) {
        characters = characters.sorted(by: { $0.name ?? "" < $1.name ?? "" })
        tableView.reloadData()
    }
    private func registerTableViewCell() {
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        cell.setupWith(character: characters[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.createViewController(storyboard: .main, controllerType: CharacterDetailTableViewController.self)
        vc.id = characters[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharactersTableViewController: CharactersManagerDelegate {
    func didUpdateCharacters(_ characterManager: CharactersManager, characters: [CharacterModel]) {
        DispatchQueue.main.async {
            self.characters = characters
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
