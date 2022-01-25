//
//  CharacterData.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

class CharacterModel: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var status: String?
    var species: String?
    var gender: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, image,status, species,gender
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        image = try? values.decodeIfPresent(String.self, forKey: .image)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        species = try? values.decodeIfPresent(String.self, forKey: .species)
        gender = try? values.decodeIfPresent(String.self, forKey: .gender)
    }
}
