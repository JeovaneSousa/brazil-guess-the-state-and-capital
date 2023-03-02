//
//  ContentView.swift
//  brazil-guess-the-state-and-capital
//
//  Created by Jeovane Barbosa on 28/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showErrorAlert = false
    @State private var showCorrectAlert = false
    @State private var gameOver = false
    @State private var endGame = false
    
    @State private var score = 0
    @State private var attempts = 4
    @State private var userAnswear = ""
    @State var guesses: [String] = []

    @State private var answear = States.abbreviated.randomElement()?.key ?? "Error"
    


    var body: some View {

        ZStack {
            LinearGradient(gradient: .init(colors: [.blackCool,
                                                    .purpleCool,
                                                    .pinkCool,
                                                    .graCool]),
                           startPoint: .top,
                           endPoint: .bottom)
            
            VStack(spacing: 20) {
                Text("Guess the State")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.primary)
                
                Image("Colored_States")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 20)
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    Text("What state of Brazil is this?")
                        .foregroundStyle(.secondary)
                        
                    Text(States.abbreviated[answear]!)
                        .font(.largeTitle.weight(.medium))
                        .foregroundStyle(.primary)

                    HStack {
                        Text("STATE:")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.primary)
                        
                        TextField("Take a guess", text: $userAnswear)
                            .border(.secondary,width: 2)
                            .multilineTextAlignment(.center)
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.primary)
                            .autocorrectionDisabled()
                    }
                    
                    Button {
                        checkAnswear()
                        
                    } label: {
                        Label("Press to confirm", systemImage: "play.fill")
                            .foregroundColor(.secondary)
                            .padding(.vertical, 20)
                    }
                }
                .padding()
                .background(Color.blackCool.opacity(0.2))
                .clipShape(RoundedRectangle.init(cornerRadius: 20))
                   
                    VStack(spacing: 140) {
                        Text("Score: \(score)")
                            .font(.title.weight(.bold))
                            .foregroundStyle(.secondary)
                        
                        
                        Text("Attempts: \(attempts)")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
            }.padding()
        }
        .ignoresSafeArea()
        
        .alert("Right answear!", isPresented: $showCorrectAlert) {
            Button("Continue") {
                getNewAnswear()
            }
            
        } message: {
            Text("Congratz! Your score is now: \(score)")
        }
        
        .alert("Wrong answear! The answear was: \(answear)", isPresented: $showErrorAlert) {
            Button("Continue") {
                if attempts == 0 {
                    gameOver = true
                } else {getNewAnswear()}
            }
            
        } message: {
            Text("Oops! You have \(attempts) attempts left")
        }
        
        .alert("Game Over", isPresented: $gameOver) {
            Button("Try Again") {
                restart()
            }

        } message: {
            Text("Better luck next time!")
        }
        
        .alert("Yay!",isPresented: $endGame) {
            Button("Try Again") {
                restart()
            }
            
        } message: {
            Text("You finished the game!")
        }
    }
    
    private func checkAnswear() {
        
        if guesses.count == States.abbreviated.keys.count {
            endGame = true
        }
        
        if userAnswear.capitalized == answear.capitalized {
            score += 1
            showCorrectAlert = true

        } else {
            attempts -= 1
            showErrorAlert = true
        }
        
        guesses.append(answear)
        userAnswear = ""
    }
    
    private func restart() {
        attempts = 4
        score = 0
        guesses = []
        getNewAnswear()
    }
    
    private func getNewAnswear() {
        answear = States.abbreviated.keys
            .filter{!guesses.contains($0)}.randomElement() ?? "Error"
    }
}
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
