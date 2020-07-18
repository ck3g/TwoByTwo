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
    default:
      return firstNumber * secondNumber
    }
  }

  var toString: String {
    "\(firstNumber) \(sign) \(secondNumber) = ?"
  }
}
