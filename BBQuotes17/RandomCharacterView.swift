//
//  RandomCharacterView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 2/11/2567 BE.
//

import SwiftUI

struct RandomCharacterView: View {
    let vm: ViewModel
    let width: Double
    let height: Double
    @Binding var showRandomCharacterInfo: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: vm.randomCharacter.images.randomElement()) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: width/1.1, height: height/2.2)
            
            Text(vm.randomCharacter.name)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
        }
        .frame(width: width/1.1, height: height/2.2)
        .clipShape(.rect(cornerRadius: 50))
        .onTapGesture {
            showRandomCharacterInfo.toggle()
        }
        
        VStack(alignment: .leading){
            Text("\(vm.randomCharacter.name) in: ")
            ForEach(vm.randomCharacter.productions, id: \.self){ prod in
                Text(prod)
            }
        }
        .minimumScaleFactor(0.5)
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black.opacity(0.5))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    RandomCharacterView(vm: ViewModel(), width: 402, height: 874, showRandomCharacterInfo: .constant(false))
}
