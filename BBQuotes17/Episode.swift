//
//  Episode.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 1/11/2567 BE.
//

import Foundation

struct Episode: Decodable{
    let episode: Int
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    var seasonEpisode: String{
        var episodeString = String(episode)
        let season = episodeString.removeFirst()
        
        if episodeString.first! == "0"{
            episodeString = String(episodeString.removeLast())
        }
        
        return "Season \(season) Episode \(episodeString)"
    }
}
