//
//  ContentView.swift
//  TwoByTwo
//
//  Created by Vitali Tatarintev on 18.11.19.
//  Copyright © 2019 Vitali Tatarintev. All rights reserved.
//

import SwiftUI

struct ChangeDifficultyButton: View {
  let label: String
  let disabled: Bool
  let size: CGFloat
  let action: () -> Void

  var body: some View {
    Button(action: self.action) {
      Text(self.label)
        .padding(10)
        .frame(width: self.size, height: self.size)
        .background(self.disabled ? Color.gray : Color("AppOrange"))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
    }
    .disabled(self.disabled)
  }
}

struct SelectExerciseTypeButton: View {
  let label: String
  let selected: Bool
  let width: CGFloat
  let height: CGFloat
  let action: () -> Void

  var body: some View {
    Button(action: self.action) {
      Text(self.label)
        .frame(width: self.width, height: self.height)
        .padding(10)
        .foregroundColor(self.selected ? Color("AppOrange") : Color.gray)
        .overlay(
          RoundedRectangle(cornerRadius: UISettings.cornerRadius)
            .stroke(self.selected ? Color("AppOrange") : Color.gray, lineWidth: 2)
        )
    }
  }
}

struct ContentView: View {
  @Environment(\.horizontalSizeClass) var sizeClass

  @EnvironmentObject var settings: PracticeSettings

  let numberOfQuestions = ["5", "10", "20", "All"]

  @State private var practiceRange = 4
  @State private var additionSumRange = 20
  @State private var subtractionNumber = 20
  @State private var selectedNumberOfQuestions = "10"
  @State private var isPracticeStarted = false
  @State private var exerciseType: ExerciseTypes = ExerciseTypes.multiplication

  let minPracticeRange = 2
  let maxPracticeRange = 10
  var practiceButtonSize: CGFloat {
    sizeClass == .compact ? 70 : 50
  }

  let additionMinSumRange = 10
  let additionMaxSumRange = 100

  let subtractionMinNumber = 10
  let subtractionMaxNumber = 100

  var body: some View {
    GeometryReader { geo in
      VStack {
        Text("Two times Two")
          .font(self.sizeClass == .compact ? .largeTitle : .title)
          .padding(.top, self.sizeClass == .compact ? 20 : 10)

        GeometryReader { _ in
          ScrollView(showsIndicators: false) {
            VStack {
              // Multiplication exercise
              Group {
                HStack {
                  ChangeDifficultyButton(label: "-", disabled: self.practiceRange <= self.minPracticeRange, size: self.practiceButtonSize) {
                    guard self.practiceRange > self.minPracticeRange else { return }
                    self.practiceRange -= 1
                    self.exerciseType = ExerciseTypes.multiplication
                  }

                  SelectExerciseTypeButton(
                    label: "\(self.practiceRange) · \(self.maxPracticeRange)",
                    selected: self.exerciseType == ExerciseTypes.multiplication,
                    width: self.screenWidth(geo) - (self.practiceButtonSize * 2) - 34,
                    height: self.practiceButtonSize - 20
                  ) {
                      self.exerciseType = ExerciseTypes.multiplication
                  }

                  ChangeDifficultyButton(label: "+", disabled: self.practiceRange >= self.maxPracticeRange, size: self.practiceButtonSize) {
                    guard self.practiceRange < self.maxPracticeRange else { return }
                    self.practiceRange += 1
                    self.exerciseType = ExerciseTypes.multiplication
                  }
                }
              }
                .padding([.top, .bottom], 10)
                .font(.title)

              // Addition exercise
              Group {
                HStack {
                  ChangeDifficultyButton(label: "-", disabled: self.additionSumRange <= self.additionMinSumRange, size: self.practiceButtonSize) {
                    guard self.additionSumRange > self.additionMinSumRange else { return }
                    self.additionSumRange -= 10
                    self.exerciseType = ExerciseTypes.addition
                  }

                  SelectExerciseTypeButton(
                    label: "A + B = \(self.additionSumRange)",
                    selected: self.exerciseType == ExerciseTypes.addition,
                    width: self.screenWidth(geo) - (self.practiceButtonSize * 2) - 34,
                    height: self.practiceButtonSize - 20
                  ) {
                    self.exerciseType = ExerciseTypes.addition
                  }

                  ChangeDifficultyButton(label: "+", disabled: self.additionSumRange >= self.additionMaxSumRange, size: self.practiceButtonSize) {
                    guard self.additionSumRange < self.additionMaxSumRange else { return }
                    self.additionSumRange += 10
                    self.exerciseType = ExerciseTypes.addition
                  }
                }
              }
                .padding([.top, .bottom], 10)
                .font(.title)

              // Subtraction exercise
              Group {
                HStack {
                  ChangeDifficultyButton(label: "-", disabled: self.subtractionNumber <= self.subtractionMinNumber, size: self.practiceButtonSize) {
                    guard self.additionSumRange > self.additionMinSumRange else { return }
                    self.subtractionNumber -= 10
                    self.exerciseType = ExerciseTypes.subtraction
                  }

                  SelectExerciseTypeButton(
                    label: "\(self.subtractionNumber) - B",
                    selected: self.exerciseType == ExerciseTypes.subtraction,
                    width: self.screenWidth(geo) - (self.practiceButtonSize * 2) - 34,
                    height: self.practiceButtonSize - 20
                  ) {
                    self.exerciseType = ExerciseTypes.subtraction
                  }

                  ChangeDifficultyButton(label: "+", disabled: self.subtractionNumber >= self.subtractionMaxNumber, size: self.practiceButtonSize) {
                    guard self.subtractionNumber < self.subtractionMaxNumber else { return }
                    self.subtractionNumber += 10
                    self.exerciseType = ExerciseTypes.subtraction
                  }
                }
              }
                .padding([.top, .bottom], 10)
                .font(.title)

              Group {
                Text("Number of questions?")
                  .font(.headline)
                  .padding(10)
                  .padding(.top, self.sizeClass == .compact ? 20 : 10)

                HStack(alignment: .center) {
                  ForEach(self.numberOfQuestions, id: \.self) { questionNumber in
                    Button(action: {
                      self.selectedNumberOfQuestions = questionNumber
                    }) {
                      Text(questionNumber)
                        .frame(width: self.sizeClass == .compact ? 50 : 100)
                        .padding(18)
                        .background(Color("AppGreen"))
                        .foregroundColor(.white)
                        .font(questionNumber == self.selectedNumberOfQuestions ? .title : .body)
                        .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
                    }
                  }
                }
              }

              Spacer()
            }
          }
        }

        Button(action: {
          self.settings.exerciseType = self.exerciseType
          self.isPracticeStarted = true
          self.settings.practiceRange = self.practiceRange
          self.settings.additionSumRange = self.additionSumRange
          self.settings.subtractionNumber = self.subtractionNumber
          self.settings.selectedNumberOfQuestions = self.selectedNumberOfQuestions
        }) {
          Image(systemName: "play.fill")
            .padding(25)
            .frame(width: self.screenWidth(geo))
            .background(Color("AppBlue"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
        }
        .padding(.bottom, 15)
      }
    }
    .onAppear(perform: {
      self.practiceRange = self.settings.practiceRange
      self.additionSumRange = self.settings.additionSumRange
      self.subtractionNumber = self.settings.subtractionNumber
      self.selectedNumberOfQuestions = self.settings.selectedNumberOfQuestions
    })
    .sheet(isPresented: $isPracticeStarted) {
      PracticeView().environmentObject(self.settings)
    }
  }

  func screenWidth(_ geo: GeometryProxy) -> CGFloat {
    let factor: CGFloat = sizeClass == .compact ? 0.9 : 0.7
    return geo.size.width * factor
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(PracticeSettings())
  }
}
