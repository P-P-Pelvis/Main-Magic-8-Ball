//
//  ContentView.swift
//  Main Magic 8 Ball
//
//  Created by Edwin Tovar on 11/18/25.
//

import SwiftUI
import UIKit

// MARK: - Simple Shake Detector (UIViewRepresentable)
//Ai generated - prompt : "How can i make it so when the phone shakes the message chages"
final class ShakeView: UIView {
    override var canBecomeFirstResponder: Bool { true }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        becomeFirstResponder()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            onShake?()
        }
        super.motionEnded(motion, with: event)
    }
    var onShake: (() -> Void)?
}

struct ShakeDetector: UIViewRepresentable {
    var onShake: () -> Void
    func makeUIView(context: Context) -> ShakeView {
        let v = ShakeView(frame: .zero)
        v.onShake = onShake
        v.isUserInteractionEnabled = false
        v.backgroundColor = .clear
        return v
    }
    func updateUIView(_ uiView: ShakeView, context: Context) {
        uiView.onShake = onShake
    }
}
//Ai generated
struct ContentView: View {
    @State private var randomValue = 0
    @State private var rotation = 0.0
    @State private var messageOpacity = 1.0
    let messages: [String] = [ // Array that stores possible messages
        "It is certain", // Questions 0 - 20
        "Ask again later",
        "Don't count on it",
        "Outlook good",
        "Very doubtful",
        "Yes, definitely",
        "Better not tell you now",
        "Signs point to yes",
        "The 8-Ball is tired, Go Google it",
        "Why would you even want to know that?",
        "Sure. If you believe in miracles",
        "Ask when you stop being delusional",
        "The answer is yes... just kidding, it’s no",
        "Im not a miracle ball",
        "Outlook not good",
        "You already know the answer is no",
        "WOW, does stupiditi run in the family?",
        "A ball wont pay the mortgage",
        "idk",
        "Delusion delusion delusion... ",
        "Need therapy for that question"
    ]
    
    private func rerollMessage() { // Function that rerolls the message and adds the fade in effect and also controlls the 9ball animation
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2)) {
            rotation += 360
        }
        messageOpacity = 0
        randomValue = Int.random(in: 0..<messages.count)
        withAnimation(.easeIn(duration: 0.35)) {
            messageOpacity = 1
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ShakeDetector { // Invisible shake listener, checks when the phone is shaken
                    rerollMessage()
                }
                .frame(width: 0, height: 0)
                Text("Magic 8 Ball")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
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
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .opacity(messageOpacity)
                Button("Shake") { // Animate rotation and pick a new random index
                    rerollMessage()
                }
                .buttonStyle(CustomButtonStyle())
                .padding(.top, 16)
                NavigationLink("How to Use", destination: InstructionsView())
                    .buttonStyle(CustomButtonStyle())
                    .padding()
                Spacer()
            } // End Vstack
        }// End NavigationView
    } // End BodyView
} //End ContentView

#Preview {
    ContentView()
}
struct CustomButtonStyle: ButtonStyle { // Adds a custom/changable style to buttons
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
struct InstructionsView: View { // The instructuion view, shows the instructions
    var body: some View {
        ZStack{
            Color.white.opacity(0.5).ignoresSafeArea()
            VStack{
                Image("9ball").resizable().frame(width: 150, height: 150)
                Text("Eight Ball")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                VStack(alignment: .leading) { // Add text to view
                    Text("WOWZERS! instructions for a magic 8 ball")
                        .padding()
                    Text("1. Just ask me a question")
                        .padding()
                    Text("2. Shake the phone or hit the shake button")
                        .padding()
                    Text("3. Then I'll respond with a yes, no, or maybe. Depending on how stupid the question was")
                        .padding()
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
        }
    }
}
