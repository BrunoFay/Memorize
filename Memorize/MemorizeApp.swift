//
//  MemorizeApp.swift
//  Memorize
//
//  Created by bruno alves fay on 07/05/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var model = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: model )
        }
    }
}
