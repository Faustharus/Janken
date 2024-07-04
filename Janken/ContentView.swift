//
//  ContentView.swift
//  Janken
//
//  Created by Damien Chailloleau on 04/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldIWin: Bool = false
    @State private var yourMove: String = ""
    @State private var aiMove: String = ""
    
    @State private var yourScore: Int = 0
    @State private var aiScore: Int = 0
    
    @State private var round: Int = 10
    
    @State private var variableTest: Double = 0.0
    
    @State private var alertTitle: String = ""
    @State private var alertText: String = ""
    
    @State private var showingAlert: Bool = false
    
    let allMoves = ["✌️", "🫱", "🤜", "🤏", "🖖"]
    
    let loseMoves = ["🖖", "✌️", "🫱", "🤜", "🤏"]
    let winMoves = ["🫱", "🤜", "🤏", "🖖", "✌️"]
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    LinearGradient(stops: [
                        .init(color: .blue, location: 0.50),
                        .init(color: .red, location: 0.50)
                    ], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            Text("\(aiMove)")
                                .font(.system(size: geo.size.width * 0.5, weight: .none, design: .default))
                            Text("AI Move:")
                                .foregroundStyle(.white)
                                .font(.title.weight(.semibold).lowercaseSmallCaps())
                                .shadow(radius: 3, x: 3, y: -3)
                        }
                        
                        Rectangle()
                            .frame(width: .infinity, height: 5)
                        
                        VStack {
                            Text("Your Move:")
                                .foregroundStyle(.white)
                                .font(.title.weight(.semibold).lowercaseSmallCaps())
                                .shadow(radius: 3, x: -3, y: 3)
                            Text("\(yourMove)")
                                .font(.system(size: geo.size.width * 0.5, weight: .none, design: .default))
                                
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            Rectangle()
                                .frame(width: .infinity, height: 1.5)
                                .foregroundStyle(.secondary)
                            HStack(spacing: 15) {
                                ForEach(0 ..< allMoves.count, id: \.self) { item in
                                    ButtonMovesView(moves: allMoves[item]) {
                                        victoryCondition(item)
                                    }
                                }
                            }
                        }
                    }
                    .alert(alertTitle, isPresented: $showingAlert) {
                        Button("Restart") {
                            endGame()
                        }
                    } message: {
                        Text(alertText)
                    }
                    .navigationTitle("Janken")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            HStack {
                                Text("🤖 :")
                                    .font(.system(size: 35))
                                Text("\(aiScore)")
                                    .font(.title)
                                    .bold()
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Text("\(yourScore)")
                                    .font(.title)
                                    .bold()
                                Text(": 🙂")
                                    .font(.system(size: 35))
                            }
                        }
                    }
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}

// MARK: Functions & Computed Properties
extension ContentView {
    
    func victoryCondition(_ position: Int) {
        shouldIWinTheGame()
        
        if shouldIWin {
            self.yourMove = allMoves[position]
            self.aiMove = winMoves[position]
            yourScore += 1
        } else {
            self.yourMove = allMoves[position]
            self.aiMove = loseMoves[position]
            aiScore += 1
        }
        round -= 1
        
        
        if round == 0 || aiScore + yourScore == 10 {
            winnerIs()
            self.showingAlert = true
        }
    }
    
    func shouldIWinTheGame() {
        self.variableTest = Double.random(in: 0 ... 1)
        if variableTest < 0.6 {
            shouldIWin = true
        } else {
            shouldIWin = false
        }
    }
    
    func endGame() {
        variableTest = 0.0
        yourScore = 0
        aiScore = 0
        round = 10
        yourMove = ""
        aiMove = ""
    }
    
    func winnerIs() {
        if aiScore > yourScore {
            alertTitle = "Winner: AI"
            alertText = "Score of \(aiScore)/10"
        } else if aiScore == yourScore {
            alertTitle = "Draw"
            alertText = "That's a Tie"
        } else {
            alertTitle = "Winner: You"
            alertText = "Score of \(yourScore)/10"
        }
    }
    
}
