//
//  BasePaginationModel.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

class BaseModel: Codable {
    var results: [CharacterModel] = []
    private enum CodingKeys: String, CodingKey {
        case results
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let results = try? values.decodeIfPresent([CharacterModel].self, forKey: .results) {
            self.results = results
        }
    }
}



