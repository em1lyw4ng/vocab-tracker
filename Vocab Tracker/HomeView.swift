//
//  HomeView.swift
//  Vocab Tracker
//
//  Created by Emily on 4/14/22.
//

import SwiftUI

// TODO: figure out how to populate with sets infinitely and navigate to them individually
/* pseudo (ideas):
    *for knowing how much to populate use for and array.size() of array holding sets
    *embed inside scrollview
*/

struct HomeView: View {
    @State private var selection: String? = nil
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    // ForEach has to be here
                    
                    
                    
                    // hard-coded working button TODO: embed in forEach
                    // TODO: each one embeds navLink
                    // navigation links
                    NavigationLink(destination: Text("View A"), // each view for the links should be distinct
                                   tag: "A", selection: $selection) { EmptyView() }
                    
                    NavigationLink(destination: Text("View B"), tag: "B", selection: $selection) { EmptyView() }
                    
                    // corresponding buttons
                    Button("Tap to show A") {
                        self.selection = "A"
                    }
                    
                    Button("Tap to show B") {
                        self.selection = "B"
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
