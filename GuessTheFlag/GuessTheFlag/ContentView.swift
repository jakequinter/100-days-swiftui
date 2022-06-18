//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jake Quinter on 6/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var alertTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia",  "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var questionIteration = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            if questionIteration < 8 {
                Button("Continue", action: shuffleGame)
            } else {
                Button("Restart", action: restartGame)
            }
        } message: {
            if questionIteration < 8 {
                Text("Your score is \(playerScore)")
            } else {
                Text("Your final score is \(playerScore) / 8")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        questionIteration += 1
        
        if number == correctAnswer {
            playerScore += 1
        }
        
        handleAlertMessage(number)
    }
    
    func handleAlertMessage(_ number: Int) {
        if questionIteration < 8 && number == correctAnswer {
            alertTitle = "Correct"
        } else if questionIteration < 8 && number != correctAnswer {
            alertTitle = "Wrong! That is the flag of \(countries[number])"
        } else {
            alertTitle = "You've finished!"
        }
        
        showingAlert = true
    }
    
    func restartGame() {
        shuffleGame()
        questionIteration = 0
        playerScore = 0
    }
    
    func shuffleGame() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
