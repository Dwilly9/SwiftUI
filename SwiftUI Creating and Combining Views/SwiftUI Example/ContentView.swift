//
//  ContentView.swift
//  SwiftUI Example
//
//  Created by Daniel Williams on 20/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            // View to display the map
            MapView()
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            // View to display the circle image
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            // View to display the text underneath image
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }.padding()
            // Spacer to push elements to the top
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
