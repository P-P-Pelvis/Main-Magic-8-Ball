//
//  ContentView.swift
//  Main Magic 8 Ball
//
//  Created by Edwin Tovar on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var randomValue = 0
    @State private var rotation = 0.0
    @State private var messageOpacity = 1.0
    let messages: [String] = [ // Array that stores possible messages
        "It is certain",
        "Ask again later",
        "Don't count on it",
        "Outlook good",
        "Very doubtful",
        "Yes, definitely",
        "Better not tell you now",
        "Signs point to yes"
        ]
    var body: some View {
            VStack {
            Text("Magic 8 Ball")
                .font(.largeTitle)
                .bold()
            Image("9ball")
                .resizable()
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(rotation))
                .rotation3DEffect(.degrees(rotation), axis: (x: 1 , y: 1, z: 0))
                .padding(50)
            Text(messages[randomValue])
                .font(.largeTitle)
                .bold()
                .padding()
                .opacity(messageOpacity)
            Button("Shake") { // Animate rotation and pick a new random index
                withAnimation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)) {
                    rotation += 360
                }
                messageOpacity = 0
                randomValue = Int.random(in: 0..<messages.count)
                withAnimation(.easeIn(duration: 0.35)) {
                    messageOpacity = 1
                }
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.top, 16)
        } // End Vstack
    } // End BodyView
} //End ContentView

#Preview {
    ContentView()
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100)
            .font(.system(size: 20, weight: .semibold))
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.black.opacity(configuration.isPressed ? 0.6 : 1.0))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
