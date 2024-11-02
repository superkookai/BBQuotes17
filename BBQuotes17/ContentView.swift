//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 30/10/2567 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Sual", systemImage: "briefcase")
                }
            
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("El Camino", systemImage: "car")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
