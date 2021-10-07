//
//  EmojiGameView.swift
//  ConcentrationHW3
//
//  Created by Katie Bankhead on 9/8/21.
//

// VIEW

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    // no side effects, so function name is a noun
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.fixed(Constants.desiredCardWidth)), count: Int(size.width / Constants.desiredCardWidth))
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                gameBody
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Concentration")
            .navigationBarItems(leading: Button("New Game") {
                withAnimation {
                    emojiGame.reset()
                }
            }, trailing: Text("Score: \(emojiGame.score)"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var gameBody: some View {
        GeometryReader { geometry in
            AspectVGrid(items: emojiGame.cards, aspectRatio: 2/3) {
                card in
                    CardView(card: card)
                    .padding(geometry.size.width * 0.01)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                emojiGame.choose(card)
                            }
                    }
            }
            .padding(geometry.size.width * 0.01)
            .foregroundColor(.blue)
        }
    }
    
    private struct Constants {
        static let desiredCardWidth: CGFloat = 110
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame())
    }
}
