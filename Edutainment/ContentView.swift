//
//  ContentView.swift
//  Edutainment
//
//  Created by Anton Serdyuchenko on 26.12.2024.
//

import SwiftUI

struct ContentView: View {
    // State to determine whether the game is active or whether you’re asking for settings.
    @State private var active = false
    // Multiplication tables user want to practice.
    @State private var multiplicationTables: Int = 10
    // Number of questions.
    @State private var questionsCount: Int = 5
    // Questions.
    var questions: [Int] = [5, 10, 20]
    // Number of Asked questions.
    @State private var askedQuestionsCount: Int = 0
    // Score.
    @State private var score: Int = 0
    // User answer.
    @State private var userAnswer: Int?
    // First number.
    @State private var firstNumber: Int = 0
    // Second number.
    @State private var secondNumber: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {

                // The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
                Section("Which multiplication tables you want to practice?") {
                    Stepper("Multiplication of \(multiplicationTables)", value: $multiplicationTables, in: 2...12)
                }
                
                Section("How many questions you want to be asked: 5, 10, or 20?") {
                    Picker("Number of questions", selection: $questionsCount) {
                        ForEach(questions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Button("Start game") {
                    start()
                }

                if(active) {
                    Section("What is correct answer?") {
                        Text("\(firstNumber) * \(secondNumber) = ?")
                        TextField("Enter your answer", value: $userAnswer, format: .number)
                        Button("Answer") {
                            answer(userAnswer)
                        }
                    }
                    Text("Your score is \(score)")
                }
                

            }
            .navigationBarTitle("Edutainment")
        }
    }
    
    func start() {
        // create new numbers
        resetAnswer()
        active = true
    }
    
    func answer(_ answer: Int?) {
        let correctAnswer = firstNumber * secondNumber
        if correctAnswer == answer {
            score += 1
        }
        
        askedQuestionsCount += 1
        
        if askedQuestionsCount == questionsCount {
            resetGame()
        }
        
        // reset answer and numbers
        resetAnswer()
    }
    
    func resetAnswer() {
        userAnswer = nil
        firstNumber = Int.random(in: 1...multiplicationTables)
        secondNumber = Int.random(in: 1...multiplicationTables)
    }
    
    func resetGame() {
        score = 0
        askedQuestionsCount = 0
        active = false
    }
}

#Preview {
    ContentView()
}
