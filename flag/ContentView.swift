//
//  ContentView.swift
//  flag
//
//  Created by dan on 10/13/19.
//  Copyright © 2019 dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var flags = ["Spain", "US", "Nigeria", "Estonia", "Russia", "France", "UK", "Germany", "Ireland", "Italy"]
    
    @State private var correctFlag = Int.random(in: 0...2);
    
    @State private var isShowingAlert = false
    @State private var yourScore = ""
    @State private var timesWon = 0
    @State private var timesPlayed = 0
    
    func flagTapped(_ number: Int) -> Void {
        timesPlayed += 1
        if number == correctFlag {
            yourScore = "Correct Flag"
            timesWon += 1
        } else {
            yourScore = "Wrong Flag"
        }
        
        isShowingAlert = true
    }
    
    func askQuestion() {
        flags.shuffle()
        correctFlag = Int.random(in: 0...2)
    }
    
    func stateOfGameMessage() -> String {
        var message = "Won \(timesWon) / \(timesPlayed)"
        
        if timesPlayed >= 1 {
            message = timesWon > 1 ? message : "Keep trying mate"
        } else {
            message = "Get started. Tap the correct flag"
        }
        return message
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 40) {
                
                Text("Sheldon Cooper's flag game")
                    .font(.headline)
                    .fontWeight(.black)
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.flags[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.white, lineWidth: CGFloat(1)))
                    }
                        
                    .alert(isPresented: self.$isShowingAlert) {
                        Alert(title: Text(self.yourScore), message: Text("Your Score is ???"), dismissButton: .default(Text("Ok")){
                            self.askQuestion()
                            })
                    }
            }
                
                Section(header: Text("Score Tally").font(.headline)){
                    Text(stateOfGameMessage())
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
