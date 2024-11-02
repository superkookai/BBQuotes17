//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 2/11/2567 BE.
//

import SwiftUI

struct QuoteView: View {
    let vm: ViewModel
    let width: Double
    let height: Double
    @Binding var showCharacterInfo: Bool
    
    var body: some View {
        Text("\"\(vm.quote.quote)\"")
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
        
        ZStack(alignment: .bottom) {
            AsyncImage(url: vm.character.images.randomElement()) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: width/1.1, height: height/2.2)
            
            Text(vm.quote.character)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
        }
        .frame(width: width/1.1, height: height/2.2)
        .clipShape(.rect(cornerRadius: 50))
        .onTapGesture {
            showCharacterInfo.toggle()
        }
    }
}

#Preview {
    QuoteView(vm: ViewModel(), width: 402, height: 874, showCharacterInfo: .constant(false))
}

//iPhone 16 pro width 402 point x height 874 point
//Search Documentation by Layout
//.frame(width: width/1.1, height: height/1.8)
