//
//  GameView.swift
//  LetFateDecide
//
//  Created by Gorkem Turan on 27.12.2022.
//

import SwiftUI

struct ImageView: View {
    let imageName: String
    
    var body: some View {

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350)
                .padding(.vertical, 20)
                .background(.regularMaterial)
        
    }
}

struct GameView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var options = ["Rock", "Paper","Scissors"]
    @State private var computerAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var round = 1
    
    @State private var gameOver = false
    @Binding var isGameContinue : Bool
    
    @State private var result = -1
    @State private var chosenWeapon = -2
    
    @State private var animate = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Choose your weapon!")
                    .foregroundColor(.blue)
                    .font(.title.bold())
                ForEach(0..<3) { selection in
                    Button {
                        tapped(selection)
                        chosenWeapon = selection
                        animate.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 350)
                                .foregroundColor(animate && result == 0 && chosenWeapon == selection ? .blue : animate && result == 1 && chosenWeapon == selection ? .red : animate && result == 2 && chosenWeapon == selection ? .green : .clear)
                            ImageView(imageName: options[selection])


//                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .animation(.easeInOut.speed(0.7), value: animate)
                    }
                }
                HStack {
                    Spacer()
                    Button("New Game") {
                        newGame()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .foregroundColor(.white)
                    Spacer()
                    VStack {
                        Text("Score: \(score)")
                            .foregroundColor(.blue)
                            .font(.title.bold())
                        Text("Round: \(round)")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button("Main Menu") {
                        toMainMenu()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: newRound)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Game is over", isPresented: $gameOver ) {
                Button("New Game", action: newGame)
                Button("Main Menu", action: toMainMenu)
            } message: {
                Text("Your score is \(score)")
            }
//            .navigationTitle("Rock Paper Scissors")
        }
    }
    func tapped (_ selection: Int) {

        if selection == 0 {
            if options[computerAnswer] == "Rock" {
                scoreTitle = "Draw. Computer picked 🪨"
                score += 0
                result = 0
            } else if options[computerAnswer] == "Paper" {
                scoreTitle = "Lose. Computer picked 📜"
                score += -1
                result = 1
            } else {
                scoreTitle = "Win. Computer picked ✂️"
                score += 1
                result = 2
            }
        } else if selection == 1 {
            if options[computerAnswer] == "Rock" {
                scoreTitle = "Win. Computer picked 🪨"
                score += 1
                result = 2
            } else if options[computerAnswer] == "Paper" {
                scoreTitle = "Draw. Computer picked 📜"
                score += 0
                result = 0
            } else {
                scoreTitle = "Lose. Computer picked ✂️"
                score += -1
                result = 1
            }
        } else {
            if options[computerAnswer] == "Rock" {
                scoreTitle = "Lose. Computer picked 🪨"
                score += -1
                result = 1
            } else if options[computerAnswer] == "Paper" {
                scoreTitle = "Win. Computer picked 📜"
                score += 1
                result = 2
            } else {
                scoreTitle = "Draw. Computer picked ✂️"
                score += 0
                result = 0
            }
        }
        
        showingScore = true

        
    }
    func newRound() {
        if round == 5 {
            gameOver = true
            return
        }
        animate = false
        result = -1
        round += 1
        scoreTitle = ""
        chosenWeapon = -1

        
        computerAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        animate = false
        result = -1
        scoreTitle = ""
        chosenWeapon = -1
        score = 0
        round = 0
        gameOver = false
        newRound()
        
    }
    
    func toMainMenu() {
        isGameContinue = false
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isGameContinue: .constant(false))
    }
}
