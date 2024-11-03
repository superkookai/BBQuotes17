//
//  SSQuoteView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 3/11/2567 BE.
//

import SwiftUI

struct SSQuoteView: View {
    let vm: ViewModel
    let width: Double
    let height: Double
    
    var body: some View {
        Text("\"\(vm.ssQuote.quote)\"")
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
        
        ZStack(alignment: .bottom) {
            AsyncImage(url: vm.ssQuote.image) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: width/1.1, height: height/2.2)
            
            Text(vm.ssQuote.character)
                .foregroundStyle(.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
        }
        .frame(width: width/1.1, height: height/2.2)
        .clipShape(.rect(cornerRadius: 50))
    }
}

#Preview {
    SSQuoteView(vm: ViewModel(), width: 402, height: 874)
}
