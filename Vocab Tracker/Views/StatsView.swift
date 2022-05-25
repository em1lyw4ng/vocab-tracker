//
//  StatsView.swift
//  Vocab Tracker
//
//  Created by Emily on 4/16/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationView {
            Text("stats")
                .navigationTitle("Statistics")
        }
        .navigationViewStyle(.stack)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
