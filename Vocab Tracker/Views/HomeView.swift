//
//  HomeView.swift
//  Vocab Tracker
//
//  Created by Emily on 4/14/22.
//

import SwiftUI

struct HomeView: View {
    // array of sets to be displayed
    @State private var sets: [String] = ["test", "test1"]
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            Text("home")
                .navigationTitle("Home")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
