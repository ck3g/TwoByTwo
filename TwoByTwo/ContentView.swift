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
  @State private var selectedNumberOfQuestions = "10"
  @State private var isPracticeStarted = false

  var body: some View {
    GeometryReader { geo in
      VStack {
        Text("Two times Two")
          .font(.largeTitle)
          .padding(.top, self.sizeClass == .compact ? 20 : 10)

        GeometryReader { _ in
          VStack {
            Group {
              Stepper("Practice up to \(self.practiceRange)x10", value: self.$practiceRange, in: 2...10)
                .padding(.bottom, self.sizeClass == .compact ? 20 : 0)
                .frame(width: self.screenWidth(geo))

              HStack(alignment: .center) {
                ForEach(2 ..< 11) { numbersRange in
                  Button(action: {
                    self.practiceRange = numbersRange
                  }) {
                    Text("\(numbersRange)")
                      .frame(width: self.sizeClass == .compact ? 20 : 42)
                      .padding(7)
                      .background(numbersRange <= self.practiceRange ? Color.orange : Color.gray)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: 5))
                      .animation(.easeInOut)
                  }
                }
              }
            }

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
                      .background(Color.green)
                      .foregroundColor(.white)
                      .clipShape(RoundedRectangle(cornerRadius: 10))
                      .overlay(
                        withAnimation(.spring()) {
                          questionNumber == self.selectedNumberOfQuestions ? RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 3) : nil
                        }
                      )
                  }
                }
              }
            }

            Spacer()
          }
        }

        Button(action: {
          self.isPracticeStarted = true
          self.settings.practiceRange = self.practiceRange
          self.settings.selectedNumberOfQuestions = self.selectedNumberOfQuestions
        }) {
          Image(systemName: "play.fill")
            .padding(25)
            .frame(width: self.screenWidth(geo))
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
    ContentView()
  }
}
