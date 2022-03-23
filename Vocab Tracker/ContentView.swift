//
//  ContentView.swift
//  Vocab Tracker
//
//  Created by Emily on 3/9/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
            }
            .navigationTitle("Home")
        }
    }
}


struct ContentView: View {
    @State var  selectedIndex = 0
    
    let icons = ["house", "plus", "chart.bar.xaxis"]
    var body: some View {
        VStack {
            
            //Content
            ZStack {
                switch selectedIndex {
                case 0:
                    NavigationView {
                        VStack {
                            Text("First")
                        }.navigationTitle("Home")
                    }
                    
                case 1:
                    NavigationView {
                        VStack {
                            Text("Second")
                        }.navigationTitle("Create")
                    }
                    
                default:
                    NavigationView {
                        VStack {
                            Text("Third")
                        }.navigationTitle("Stats")
                    }
                    
                }

            }
            
            Spacer()
            
            Divider()
            HStack {
                ForEach(0..<3, id : \.self) {
                    number in
                    Spacer()
                    Button(action: {self.selectedIndex = number},
                           label : {
                        if number == 1 {
                            Image(systemName: icons[number])
                                .font(.system(size:25, weight: .regular, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Color.blue)
                                .cornerRadius(30)
                        }
                        else {
                            Image(systemName: icons[number])
                                .font(.system(size:25, weight: .regular, design: .default))
                                .foregroundColor(selectedIndex == number ? .black : Color(UIColor.lightGray))
                            
                        }
                    })
                      
                    if number != 2 {
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
                
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
