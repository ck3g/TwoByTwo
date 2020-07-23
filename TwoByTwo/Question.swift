//
//  Question.swift
//  TwoByTwo
//
//  Created by Vitali Tatarintev on 18.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import SwiftUI

struct Question {
  var firstNumber: Int
  var secondNumber: Int
  var exerciseType: ExerciseTypes

  var sign: String {
    switch exerciseType {
    case .addition:
      return "+"
    case .subtraction:
      return "-"
    case .division:
      return "÷"
    default:
      return "·"
    }
  }

  var result: Int {
    switch exerciseType {
    case .addition:
      return firstNumber + secondNumber
    case .subtraction:
      return firstNumber - secondNumber
    case .division:
      return firstNumber / secondNumber
    default:
      return firstNumber * secondNumber
    }
  }

  var toString: String {
    "\(firstNumber) \(sign) \(secondNumber) = ?"
  }

  static func generateQuestions(ofType exerciseType: ExerciseTypes, settings: PracticeSettings) -> [Question] {
    var questions: [Question] = []

    switch exerciseType {
    case .addition:
      for sum in 1...settings.additionSumRange {
        let firstNumber = Int.random(in: 0..<sum)
        let secondNumber = sum - firstNumber

        questions.append(Question(firstNumber: firstNumber, secondNumber: secondNumber, exerciseType: .addition))
      }

    case .subtraction:
      for firstNumber in 1...settings.subtractionNumber {
        let secondNumber = Int.random(in: 0...firstNumber)

        questions.append(Question(firstNumber: firstNumber, secondNumber: secondNumber, exerciseType: .subtraction))
      }

    case .division:
      for secondNumber in 2...settings.divisionDivider {
        for result in 1...settings.selectedNumberOfQuestions {
          let firstNumber = result * secondNumber

          questions.append(Question(firstNumber: firstNumber, secondNumber: secondNumber, exerciseType: .division))
        }
      }

    default:
      let questionsPerTable = 11
      for multiplier in 1...settings.practiceRange {
        for multiplicant in 0..<questionsPerTable {
          questions.append(Question(firstNumber: multiplier, secondNumber: multiplicant, exerciseType: .multiplication))
        }
      }
    }

    return questions
  }

  func generateAnswerSuggestions() -> [(value: Int, isCorrect: Bool)] {
    var diff = Int.random(in: 1...2)

    if self.exerciseType == .multiplication {
      diff = self.firstNumber == 0 ? 1 : self.firstNumber
    }

    var answers = [
      (value: self.result, isCorrect: true),
      (value: self.result + diff, isCorrect: false),
      (value: self.result - diff, isCorrect: false),
      (value: self.result + diff + 1, isCorrect: false)
    ]

    answers.shuffle()

    return answers
  }
}
