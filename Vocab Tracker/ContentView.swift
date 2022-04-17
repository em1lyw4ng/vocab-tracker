//
//  ContentView.swift
//  Vocab Tracker
//
//  Created by Emily on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // tab bar
        TabView {
            
            // view options
            HomeView().tabItem({
                Image(systemName: "house.fill")
                Text("Home")
            })
            
            CreateView().tabItem({
                Image(systemName: "plus")
                Text("Create")
            })
            
            StatsView().tabItem({
                Image(systemName: "chart.bar.xaxis")
                Text("Statistics")
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
