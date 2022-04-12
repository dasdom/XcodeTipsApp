//  Created by Dominik Hauser on 08.04.22.
//  
//

import SwiftUI

struct TipView: View {

  let tip: Tip
  @State private var mainIndex = 0
  @State private var stepIndex = 0
  @State private var nextDisabled = false
  @State private var previousDisabled = true

  var body: some View {
    HStack {

      PreviousButtonView(stepIndex: $stepIndex,
                         mainIndex: $mainIndex,
                         updateButtonStates: updateButtonStates)
        .disabled(previousDisabled)

      VStack {
        Text(tip.title)

        TipImageView(image: tip.steps[mainIndex].image, index: mainIndex)

        KeyboardShortcutView(keys: tip.steps[stepIndex].keys, index: stepIndex)
      }
      .padding()

      NextButtonView(stepsCount: tip.steps.count,
                     stepIndex: $stepIndex,
                     mainIndex: $mainIndex,
                     updateButtonStates: updateButtonStates)
        .disabled(nextDisabled)
    }
  }

  func updateButtonStates() {
    if stepIndex >= tip.steps.count-1 {
      nextDisabled = true
    } else {
      nextDisabled = false
    }
    if stepIndex < 1 {
      previousDisabled = true
    } else {
      previousDisabled = false
    }
  }
}

struct ContentView_Previews: PreviewProvider {

  static var previews: some View {
    TipView(tip: Tip(title: "Move Focus", steps: [
      Step(image: "move_focus_01", keys: []),
      Step(image: "move_focus_02", keys: [
        "cmd",
        "j"
      ]),
      Step(image: "move_focus_03", keys: [
        "right_arrow"
      ]),
      Step(image: "move_focus_04", keys: [
        "return"
      ])
    ]))
  }
}

struct KeyView: View {

  let key: String

  var body: some View {
    ZStack {
      Image("key_cap")
        .resizable()
        .aspectRatio(contentMode: .fit)
      Image(key)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
    }
    .background(Color.white)
    .cornerRadius(10)
    .frame(width: 80, height: 80)
  }
}

struct TipImageView: View {

  let image: String
  let index: Int

  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(minWidth: 300, idealWidth: 500, minHeight: 200)
        .drawingGroup()
        .transition(.opacity)
        .id(index)
    }
    .background(.white)
    .cornerRadius(10)
  }
}

struct KeyboardShortcutView: View {

  let keys: [String]
  let index: Int

  var body: some View {
    HStack(spacing: 0) {
      ForEach(keys, id: \.self) { key in
        KeyView(key: key)
      }
      .padding(4)
      .drawingGroup()
      .transition(.opacity)
      .id(index)
    }
    .frame(height: 100)
  }
}

struct NextButtonView: View {

  let stepsCount: Int
  @Binding var stepIndex: Int
  @Binding var mainIndex: Int
  let updateButtonStates: () -> Void

  var body: some View {
    Button(action: {
      if stepIndex < stepsCount-1 {
        withAnimation(.linear) {
          stepIndex += 1
        }
        withAnimation(.linear.delay(0.8)) {
          mainIndex += 1
        }
      }
      updateButtonStates()
    }, label: {
      Image(systemName: "chevron.right")
    })
    .keyboardShortcut(.rightArrow, modifiers: [.command])
  }
}

struct PreviousButtonView: View {

  @Binding var stepIndex: Int
  @Binding var mainIndex: Int
  let updateButtonStates: () -> Void

  var body: some View {
    Button(action: {
      if stepIndex > 0 {
        withAnimation(.linear) {
          stepIndex -= 1
          mainIndex -= 1
        }
      }
      updateButtonStates()
    }, label: {
      Image(systemName: "chevron.left")
    })
    .keyboardShortcut(.leftArrow, modifiers: [.command])
  }
}
