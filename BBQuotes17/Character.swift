//
//  Character.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 30/10/2567 BE.
//

import Foundation

struct Character: Decodable{
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    let productions: [String]
    
    //Properties not in JSON file
    var death: Death?
    
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
        case death
        case productions
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        self.productions = try container.decode([String].self, forKey: .productions)
        
//        self.death = try container.decodeIfPresent(Death.self, forKey: .death)
        
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let deathData = try Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        self.death = try deathDecoder.decode(Death.self, from: deathData)
    }
}
