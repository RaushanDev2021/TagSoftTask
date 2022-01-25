//
//  CharactersManager.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import Foundation

protocol CharactersManagerDelegate: AnyObject {
    func didUpdateCharacters(_ characterManager: CharactersManager, characters: [CharacterModel])
    func didUpdateCharacter(_ characterManager: CharactersManager, character: CharacterModel)
    func didFailWithError(error: Error)
}

extension CharactersManagerDelegate {
    func didUpdateCharacters(_ characterManager: CharactersManager, characters: [CharacterModel]) {}
    func didUpdateCharacter(_ characterManager: CharactersManager, character: CharacterModel) {}
    func didFailWithError(error: Error) {}
}

class CharactersManager {
    let charactersURL = "https://rickandmortyapi.com/api/character"
    
    weak var delegate: CharactersManagerDelegate?
    
    func fetchCharacters() {
        perform(with: charactersURL, type: BaseModel.self) { baseModel in
            self.delegate?.didUpdateCharacters(self, characters: baseModel.results)
        }
    }
    
    func fetchCharactersById(with id: Int) {
        let urlString = "\(charactersURL)/\(id)"
        perform(with: urlString, type: CharacterModel.self) { characterModel in
            self.delegate?.didUpdateCharacter(self, character: characterModel)
        }
    }
    
    func perform<T:Decodable>(with urlString: String,
                              type: T.Type,
                              completionHandler: @escaping (T) -> Void) {
            
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil{
                    self?.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let result = try? self?.parseJSON(from: safeData, type: type) {
                        completionHandler(result)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON<T : Decodable>(from data: Data, type : T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
