//
//  ContentView.swift
//  SwiftUIWarCardGame
//
//  Created by Daniel Williams on 27/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var cardValue1 = 2
    @State private var cardValue2 = 2
    
    @State private var playerScore = 0
    @State private var cpuScore = 0
    
    var body: some View {
        
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("logo")
                
                Spacer()
                
                HStack {
                    Image("card" + String(cardValue1))
                    Image("card" + String(cardValue2))
                }
                
                Spacer()
                
                Button(action: {
                    
                    // Randomize the state properties
                    self.cardValue1 = Int.random(in: 2...14)
                    self.cardValue2 = Int.random(in: 2...14)
                    
                    // Calculate score
                    if(cardValue1 > cardValue2) {
                        self.playerScore += 1
                    } else if (cardValue2 > cardValue1) {
                        self.cpuScore += 1
                    }
                    
                })
                 {
                    Image("dealbutton")
                        .renderingMode(.original)
                }
                Spacer()
                
                HStack {
                    VStack {
                        Text("Player Score: ")
                            .bold()
                            .padding(.bottom, 20)
                        Text(String(playerScore))
                    } .padding(.leading, 20)
                      .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack {
                        Text("CPU Score: ")
                            .bold()
                            .padding(.bottom, 20)
                        Text(String(cpuScore))
                    } .padding(.trailing, 20)
                      .foregroundColor(.white)
                }
                Spacer()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
