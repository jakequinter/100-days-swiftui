//
//  ContentView.swift
//  MilestoneProject2
//
//  Created by Jake Quinter on 6/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTableAmount = 5
    @State private var questionsLength = [5, 10, 15]
    @State private var numberOfQuestions = 10
    @State private var question = ""
    @State private var gameStarted = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !gameStarted {
                    Form {
                        Section {
                            Picker("Upper limit", selection: $multiplicationTableAmount) {
                                ForEach(1..<10, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            
                            Picker("Number of questions", selection: $numberOfQuestions) {
                                ForEach(questionsLength, id: \.self) { number in
                                    Text("\(number)")
                                }
                            }
                        }
                    }
                    
                    Button("Start game", action: startGame)
                } else {
                    Section {
                        Text("\(question)")
                    }
                }
            }
                
            .navigationTitle("Edutainment")
        }
    }
    
    func startGame() {
        gameStarted = true
        question = "What is 7 * 2"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
