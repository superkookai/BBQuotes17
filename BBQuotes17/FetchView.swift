//
//  FetchView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 31/10/2567 BE.
//

import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let show: String
    
    @State private var showCharacterInfo = false
    @State private var showRandomCharacterInfo = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.removeCaseAndSpaces())
                    .resizable()
                    .frame(width: geo.size.width*2.7, height: geo.size.height*1.2)
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                                .controlSize(.extraLarge)
                            
                        case .successQuote:
                            QuoteView(vm: vm, width: geo.size.width, height: geo.size.height, showCharacterInfo: $showCharacterInfo)
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .successRandomCharacter:
                            RandomCharacterView(vm: vm, width: geo.size.width, height: geo.size.height, showRandomCharacterInfo: $showRandomCharacterInfo)
                            
                        
                        case .notFoundRandomCharacter:
                            Text("Please try again!")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer(minLength: 20)
                    }
                    
                    VStack {
                        Button{
                            Task{
                                await vm.getQuoteData(for: show)
                            }
                        } label:{
                            Text("Get Random Quote")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                        }
                        
                        Button{
                            Task{
                                await vm.getEpisode(for: show)
                            }
                        } label:{
                            Text("Get Random Episode")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                                
                        }
                        
                        Button{
                            Task{
                                await vm.getRandomCharacter(for: show)
                            }
                        } label:{
                            Text("Get Random Character")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                                
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterDetailView(character: vm.character, show: show, vm: vm)
        }
        .sheet(isPresented: $showRandomCharacterInfo, content: {
            CharacterDetailView(character: vm.randomCharacter, show: show, vm: vm)
        })
        .onAppear{
            Task{
                await vm.getQuoteData(for: show)
            }
        }
    }
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
