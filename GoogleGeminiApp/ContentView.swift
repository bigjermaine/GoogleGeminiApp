//
//  ContentView.swift
//  GoogleGeminiApp
//
//  Created by MacBook AIR on 28/08/2024.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
  @AppStorage("highScore") private var highScore = 0
  @State private var score = 0
  @State private var coinPosition = CGPoint(x: 0, y: 0)
  @State private var scoreColor = colorPalette.randomElement() ?? .black
  @State private var speechSynthesizer: AVSpeechSynthesizer?
    var body: some View {
      GeometryReader { geometry in
        VStack {
          Image("coinIconImage")
            .frame(width: 100, height: 100)
            .position(coinPosition)
            .onTapGesture {
              withAnimation(.easeInOut(duration: 0.5)) {
                score += 1
                if score > highScore {
                  highScore = score
                }
                scoreColor = colorPalette.randomElement() ?? .black
                speakScore()
              }
              coinPosition = CGPoint(x: .random(in: 10...geometry.size.width - 100), y: .random(in: 10...geometry.size.height - 100))
            }
          Text("Gemini: $\(highScore)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(scoreColor)
        }
        .padding()
      }
    }
     func speakScore() {
       let utterance = AVSpeechUtterance(string:"$\(score)")
       utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
       utterance.rate = 0.1
       speechSynthesizer = AVSpeechSynthesizer()
       speechSynthesizer?.speak(utterance)
      }
}

#Preview {
    ContentView()
}
let colorPalette = [Color.red, Color.green, Color.blue, Color.yellow, Color.purple]
