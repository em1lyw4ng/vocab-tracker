//
//  TabBar.swift
//  Vocab Tracker
//
//  Created by Emily on 5/16/22.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            
            CreateView().tabItem {
                Label("Create", systemImage: "plus")
            }
            
            StatsView().tabItem {
                Label("Statistics", systemImage: "chart.bar.xaxis")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
