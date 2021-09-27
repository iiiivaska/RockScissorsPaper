//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Василий Буланов on 9/26/21.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var appSelect = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var gamesCount = 0
    @State private var endGame = false
    var moves = ["Rock", "Paper", "Scissors"]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack {
                Text("Score: \(score)")
                    .titleStyle()
                Text("App move: \(moves[appSelect])")
                    .titleStyle()
                Text("Player should: \(shouldWin ? "Win": "Lose")")
                    .foregroundColor(shouldWin ? .green : .red)
                    .font(.largeTitle)
                    .padding()
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.buttonTapped(number)
                        }) {
                            Image(moves[number])
                                .padding()
                        }
                    }
                }
            }
            .alert(isPresented: $endGame) {
                Alert(title: Text("End of Round"), message: Text("Your Score: \(score)"), dismissButton: .default(Text("OK")) {
                    endOfGame()
                })
            }
        }
    }
    
    func endOfGame() {
        score = 0
        gamesCount = 0
        appSelect = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func buttonTapped(_ number: Int) {
        if (shouldWin)
        {
            switch number{
            case 0:
                if (appSelect == 2)
                {
                    score += 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score - 1
                }
                break
            case 1:
                if (appSelect == 0)
                {
                    score += 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score - 1
                }
                break
            case 2:
                if (appSelect == 1)
                {
                    score += 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score - 1
                }
                break
            default:
                break
            }
        } else {
            switch number{
            case 0:
                if (appSelect == 2)
                {
                    score -= 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score + 1
                }
                break
            case 1:
                if (appSelect == 0)
                {
                    score -= 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score + 1
                }
                break
            case 2:
                if (appSelect == 1)
                {
                    score -= 1
                } else {
                    self.score = (number - appSelect == 0) ? score : score + 1
                }
                break
            default:
                break
            }
        }
        appSelect = Int.random(in: 0...2)
        shouldWin = Bool.random()
        gamesCount += 1
        if (gamesCount == 10) {
            endGame = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
