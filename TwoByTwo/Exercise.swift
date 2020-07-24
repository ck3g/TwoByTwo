//
//  Exercise.swift
//  TwoByTwo
//
//  Created by Vitali Tatarintev on 24.07.20.
//  Copyright © 2020 Vitali Tatarintev. All rights reserved.
//

import SwiftUI

struct Exercise {
  let exerciseType: ExerciseTypes
  let difficultySteps: [ExerciseTypes:Int] = [
    .addition: 10,
    .subtraction: 10,
    .division: 1,
    .multiplication: 1
  ]

  var difficultyStep: Int {
    difficultySteps[exerciseType]!
  }
}
