//
//  CharacterDetailView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 1/11/2567 BE.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ScrollViewReader{ proxy in
                ZStack(alignment: .top){
                    Image(show.removeCaseAndSpaces())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView{
                        TabView{
                            ForEach(character.images,id: \.self) { characterImageURL in
                                AsyncImage(url: characterImageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top,60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            ForEach(character.occupations, id: \.self){ occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nickname:")
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self){ aliase in
                                    Text("•\(aliase)")
                                        .font(.subheadline)
                                }
                            }else{
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (Spoiler Alert!!)"){
                                VStack(alignment: .leading){
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    if let death = character.death{
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear{
                                                    withAnimation{
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How: \(death.details)")
                                            .padding(.bottom,7)
                                        
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                            
                        }
                        .frame(width: geo.size.width/1.25, alignment: .leading)
                        .padding(.bottom, 50)
                        .id(1)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetailView(character: ViewModel().character, show: Constants.bbName)
}
