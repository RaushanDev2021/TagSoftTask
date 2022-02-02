//
//  BasePaginationModel.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

struct BaseModel {
    var characters:[CharacterModel]?
    var nextCharacterUrl:String?
}

struct RequestModel<T:Codable>:Codable {
    let info:RequestInfo?
    let results:[T]?
}

struct RequestInfo:Codable {
    let count:Int?
    let pages:Int?
    let next:String?
    let prev:String?
}

struct CharacterModel:Codable {
    let id:Int
    let name:String
    let status:String?
    let species:String?
    let gender:String?
    let image:String?
}





