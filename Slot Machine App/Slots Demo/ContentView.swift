//
//  ContentView.swift
//  Slots Demo
//
//  Created by Daniel Williams on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple","star","cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var betamount = 5
    
    var body: some View {
        
        ZStack {
            
            // Background color - 2 rectangles
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Title
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("SwiftUI Slots")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                // Credits label
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                // Card images for slots
                // Separate VStack is used because Vstack has a max of 10 items
                VStack {
                    // Top row
                    HStack {
                        Spacer()
                        
                        Cardview(symbol: $symbols[numbers[0]],
                                 background: $backgrounds[0])
                        Cardview(symbol: $symbols[numbers[1]],
                                 background: $backgrounds[1])
                        Cardview(symbol: $symbols[numbers[2]],
                                 background: $backgrounds[2])
                        
                        Spacer()
                    }
                    // Middle row
                    HStack {
                        Spacer()
                        
                        Cardview(symbol: $symbols[numbers[3]],
                                 background: $backgrounds[3])
                        Cardview(symbol: $symbols[numbers[4]],
                                 background: $backgrounds[4])
                        Cardview(symbol: $symbols[numbers[5]],
                                 background: $backgrounds[5])
                        
                        Spacer()
                    }
                    // Bottom row
                    HStack {
                        Spacer()
                        
                        Cardview(symbol: $symbols[numbers[6]],
                                 background: $backgrounds[6])
                        Cardview(symbol: $symbols[numbers[7]],
                                 background: $backgrounds[7])
                        Cardview(symbol: $symbols[numbers[8]],
                                 background: $backgrounds[8])
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                        // VStack for button to spin center row and label beneath
                        VStack {
                            Button(action: {
                                
                                processResults()
                               
                            }, label: {
                                Text("Spin")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.all,10)
                                    .padding(.horizontal, 30)
                                    .background(Color.pink)
                                    .cornerRadius(20)
                        })
                            Text("\(betamount) Credits")
                                .padding(.top, 10)
                        }
                        
                        // Button for max spin
                        VStack {
                            Button(action: {
                                
                                processResults(true)
                               
                            }, label: {
                                Text("Max spin")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.all,10)
                                    .padding(.horizontal, 30)
                                    .background(Color.pink)
                                    .cornerRadius(20)
                        })
                            Text("\(betamount * 4) Credits")
                                .padding(.top, 10)
                        }
                        
                    // End of HStack of spin buttons
                    }
                   
                Spacer()
            // End of Vstack
            }
        // End of ZStack
        }
    // End of View
    }
    
    // Function to process results
    func processResults(_ isMax:Bool = false) {
        
        // Max spin
        if(isMax) {
            
            // Make all slots white again to start
            self.backgrounds = self.backgrounds.map({ _ in Color.white })
            
            // Spin all slots
            self.numbers = self.numbers.map({ _ in Int.random(in: 0...symbols.count - 1)})
            
            // Apply winnings
            processWin(true)
            
        }
        // Middle row spin only
        else {
            
            // Make all slots white again to start
            self.backgrounds = self.backgrounds.map({ _ in Color.white })
            
            // Spin middle row
            self.numbers[3] = Int.random(in: 0...symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...symbols.count - 1)
            
            // Process winnings
            processWin(false)
            
        }
        
    }
    
    // Function to apply winnings/losses and background colors
    func processWin(_ isMax:Bool = false)
    {
        
        var matches = 0
        
        // If center spin only
        if !isMax {
            
            // If user wins
            if(self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]) {
                
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
                
                matches += 1
                
            }
            
        } // If max spin (all 5 different matches must be defined
        else {
            
            // Top row
            if isMatch(0, 1, 2) {
                matches += 1
            }
            // Middle row
            if isMatch(3, 4, 5) {
                matches += 1
            }
            // Bottom row
            if isMatch(6, 7, 8) {
                matches += 1
            }
            // First diagonal (top left to bottom right)
            if isMatch(0, 4, 8) {
                matches += 1
            }
            // Second diagonal (bottom left to top right)
            if isMatch(2, 4, 6) {
                matches += 1
            }
            // Top down on the left
            if isMatch(0, 3, 6) {
                matches += 1
            }
            // Top down in the middle
            if isMatch(1, 4, 7) {
                matches += 1
            }
            // Top down on the right
            if isMatch(2, 5, 8) {
                matches += 1
            }
            
        // End of max spin processing
        }
        
        // Add winnings based on matches
        if matches > 0 {
            // At least 1 win
            credits += matches * (3 * betamount)
            
        } else if !isMax {
            // 0 wins, single spin
            credits -= betamount
            
        } else if isMax {
            // 0 wins, max spin
            credits -= (betamount * 4)
        }
     
    // End processWin()
    }
    
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        if(self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3]) {
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            return true
        }
        return false
    }
    
// End of ContentView
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
