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
    var model:BaseModel? = BaseModel()
    weak var delegate: CharactersManagerDelegate?
    
    func fetchCharacters() {
        perform(with: model?.nextCharacterUrl ?? charactersURL, type: RequestModel<CharacterModel>.self) { requestModel in
            self.model?.nextCharacterUrl = requestModel.info?.next
            if (self.model?.characters?.count ?? 0) == 0 {
                self.model?.characters = requestModel.results
            } else {
                if let results = requestModel.results {
                    self.model?.characters?.append(contentsOf: results)
                }
            }
            self.delegate?.didUpdateCharacters(self, characters: self.model?.characters ?? [])
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
