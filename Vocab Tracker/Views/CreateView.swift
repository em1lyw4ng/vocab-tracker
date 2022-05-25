//
//  CreateView.swift
//  Vocab Tracker
//
//  Created by Emily on 4/16/22.
//

import SwiftUI

struct CreateView: View {
    var body: some View {
        NavigationView {
            Text("create")
                .navigationTitle("Create")
        }
        .navigationViewStyle(.stack)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
