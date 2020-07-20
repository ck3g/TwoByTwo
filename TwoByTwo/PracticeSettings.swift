//
//  PracticeSettings.swift
//  TwoByTwo
//
//  Created by Vitali Tatarintev on 19.11.19.
//  Copyright © 2019 Vitali Tatarintev. All rights reserved.
//

import SwiftUI
import Combine

enum ExerciseTypes {
  case multiplication
  case addition
  case subtraction
}

final class PracticeSettings: ObservableObject {
  @Published var practiceRange: Int {
    didSet {
      UserDefaults.standard.set(practiceRange, forKey: "practiceRange")
    }
  }
  @Published var additionSumRange: Int {
    didSet {
      UserDefaults.standard.set(additionSumRange, forKey: "additionSumRange")
    }
  }
  @Published var subtractionNumber: Int {
    didSet {
      UserDefaults.standard.set(subtractionNumber, forKey: "subtractionNumber")
    }
  }
  @Published var selectedNumberOfQuestions: Int {
    didSet {
      UserDefaults.standard.set(selectedNumberOfQuestions, forKey: "selectedNumberOfQuestions")
    }
  }

  var exerciseType = ExerciseTypes.multiplication

  init() {
    self.practiceRange = 4
    self.additionSumRange = 20
    self.subtractionNumber = 20
    self.selectedNumberOfQuestions = 10

    if let practiceRange = UserDefaults.standard.integer(forKey: "practiceRange") as Int? {
      self.practiceRange = practiceRange == 0 ? 4 : practiceRange
    }

    if let additionSumRange = UserDefaults.standard.integer(forKey: "additionSumRange") as Int? {
      self.additionSumRange = additionSumRange == 0 ? 20 : additionSumRange
    }

    if let subtractionNumber = UserDefaults.standard.integer(forKey: "subtractionNumber") as Int? {
      self.subtractionNumber = subtractionNumber == 0 ? 20 : subtractionNumber
    }

    if let selectedNumberOfQuestions = UserDefaults.standard.integer(forKey: "selectedNumberOfQuestions") as Int? {
      self.selectedNumberOfQuestions = selectedNumberOfQuestions == 0 ? 10 : selectedNumberOfQuestions
    }
  }
}
