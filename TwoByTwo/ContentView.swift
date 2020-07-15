//
//  ContentView.swift
//  TwoByTwo
//
//  Created by Vitali Tatarintev on 18.11.19.
//  Copyright © 2019 Vitali Tatarintev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.horizontalSizeClass) var sizeClass

  @EnvironmentObject var settings: PracticeSettings

  let numberOfQuestions = ["5", "10", "20", "All"]

  @State private var practiceRange = 4
  @State private var additionSumRange = 20
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
                  Button(action: {
                    guard self.practiceRange > self.minPracticeRange else { return }
                    self.practiceRange -= 1
                  }) {
                    Text("-")
                      .padding(10)
                      .frame(width: self.practiceButtonSize, height: self.practiceButtonSize)
                      .background(self.practiceRange > self.minPracticeRange ? Color("AppOrange") : Color.gray)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
                  }
                    .disabled(self.practiceRange <= self.minPracticeRange)

                  Button(action: {
                    self.exerciseType = ExerciseTypes.multiplication
                  }) {
                    Text("\(self.practiceRange) · \(self.maxPracticeRange)")
                      .frame(width: self.screenWidth(geo) - (self.practiceButtonSize * 2) - 34, height: self.practiceButtonSize - 20)
                      .padding(10)
                      .foregroundColor(self.exerciseType == ExerciseTypes.multiplication ? Color("AppOrange") : Color.gray)
                      .overlay(
                        RoundedRectangle(cornerRadius: UISettings.cornerRadius)
                          .stroke(self.exerciseType == ExerciseTypes.multiplication ? Color("AppOrange") : Color.gray, lineWidth: 2)
                      )
                  }

                  Button(action: {
                    guard self.practiceRange < self.maxPracticeRange else { return }
                    self.practiceRange += 1
                  }) {
                    Text("+")
                      .padding(10)
                      .frame(width: self.practiceButtonSize, height: self.practiceButtonSize)
                      .background(self.practiceRange < self.maxPracticeRange ? Color("AppOrange") : Color.gray)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
                  }
                    .disabled(self.practiceRange >= self.maxPracticeRange)
                }
              }
                .padding([.top, .bottom], 10)
                .font(.title)

              // Addition exercise
              Group {
                HStack {
                  Button(action: {
                    guard self.additionSumRange > self.additionMinSumRange else { return }
                    self.additionSumRange -= 10
                  }) {
                    Text("-")
                      .padding(10)
                      .frame(width: self.practiceButtonSize, height: self.practiceButtonSize)
                      .background(self.additionSumRange > self.additionMinSumRange ? Color("AppOrange") : Color.gray)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
                  }
                    .disabled(self.additionSumRange <= self.additionMinSumRange)

                  Button(action: {
                    self.exerciseType = ExerciseTypes.addition
                  }) {
                    Text("A + B = \(self.additionSumRange)")
                      .frame(width: self.screenWidth(geo) - (self.practiceButtonSize * 2) - 34, height: self.practiceButtonSize - 20)
                      .padding(10)
                      .foregroundColor(self.exerciseType == ExerciseTypes.addition ? Color("AppOrange") : Color.gray)
                      .overlay(
                        RoundedRectangle(cornerRadius: UISettings.cornerRadius)
                          .stroke(self.exerciseType == ExerciseTypes.addition ? Color("AppOrange") : Color.gray, lineWidth: 2)
                      )
                  }

                  Button(action: {
                    guard self.additionSumRange < self.additionMaxSumRange else { return }
                    self.additionSumRange += 10
                  }) {
                    Text("+")
                      .padding(10)
                      .frame(width: self.practiceButtonSize, height: self.practiceButtonSize)
                      .background(self.additionSumRange < self.additionMaxSumRange ? Color("AppOrange") : Color.gray)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: UISettings.cornerRadius))
                  }
                    .disabled(self.additionSumRange >= self.additionMaxSumRange)
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
