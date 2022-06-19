//
//  ContentView.swift
//  MilestoneProject1
//
//  Created by Jake Quinter on 6/19/22.
//

import SwiftUI

struct ContentView: View {
    let moves = ["rock", "paper", "scissors"]
    
    @State private var choice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Current score: \(playerScore)")
                    .font(.title.weight(.semibold))
                    .padding()
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(shouldWin ? "Win against \(moves[choice])" : "Lose against \(moves[choice])")
                    .font(.title2.weight(.medium))
                    .padding(.bottom)
                
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            userAnswered(move)
                        } label: {
                            Text("\(move)")
                        }
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Continue", action: shuffleGame)
            }
            .navigationTitle("Rock, Paper, Scissors")
        }
    }
    
    func userAnswered(_ answer: String) {
        if moves[choice] == "rock" {
            handleAnswer(winningMove: "paper", losingMove: "scissors", answer: answer)
        } else if moves[choice] == "paper" {
            handleAnswer(winningMove: "scissors", losingMove: "rock", answer: answer)
        } else if moves[choice] == "scissors" {
            handleAnswer(winningMove: "rock", losingMove: "paper", answer: answer)
        }
        
        showingAlert = true
    }
    
    func handleAnswer(winningMove: String, losingMove: String, answer: String) {
        if shouldWin && answer == winningMove {
            playerScore += 1
            alertTitle = "Nice job!"
        } else if !shouldWin && answer == losingMove {
            playerScore += 1
            alertTitle = "Nice job!"
        } else {
            alertTitle = "Oops! Wrong answer"
        }
    }
    
    func shuffleGame() {
        shouldWin = Bool.random()
        choice = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
