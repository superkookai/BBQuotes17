//
//  ViewModel.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 31/10/2567 BE.
//

import Foundation

@Observable
class ViewModel{
    enum FetchStatus{
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case successRandomCharacter
        case notFoundRandomCharacter
        case failed(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStarted
    
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: Character
    var episode: Episode
    var randomCharacter: Character
    var randomQuote: Quote
    
    init(){
        //For mock data (from sample JSON file)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
        
        randomCharacter = try! decoder.decode(Character.self, from: characterData)
        randomQuote = try! decoder.decode(Quote.self, from: quoteData)
    }
    
    //Get real data from this function
    func getQuoteData(for show: String) async {
        status = .fetching
        
        do{
            quote = try await fetcher.fetchQuote(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)

            status = .successQuote
        }catch{
            status = .failed(error: error)
        }
    }
    
    func getEpisode(for show: String) async{
        status = .fetching
        
        do{
            if let episode = try await fetcher.fetchEpisode(from: show){
                self.episode = episode
                status = .successEpisode
            }
        }catch{
            status = .failed(error: error)
        }
    }
    
    func getRandomCharacter(for show: String) async{
        status = .fetching
        
        do{
            let localRandomCharacter = try await fetcher.fetchRandomCharacter()
            for production in localRandomCharacter.productions{
                if production == show{
                    randomCharacter = localRandomCharacter
                    status = .successRandomCharacter
                    return
                }
            }
            status = .notFoundRandomCharacter
        }catch{
            status = .failed(error: error)
        }
    }
    
    func getRandomQuote(from name: String) async{
        status = .fetching
        do{
            randomQuote = try await fetcher.fetchRandomQuote(for: name)
        }catch{
            status = .failed(error: error)
        }
    }
}
