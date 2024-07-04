//
//  ButtonMovesView.swift
//  Janken
//
//  Created by Damien Chailloleau on 04/07/2024.
//

import SwiftUI

struct ButtonMovesView: View {
    typealias ActionHandler = () -> Void
    
    var moves: String
    var handler: ActionHandler
    
    init(moves: String, handler: @escaping ButtonMovesView.ActionHandler) {
        self.moves = moves
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler) {
            Text(moves)
                .font(.system(size: 30, weight: .bold, design: .default))
        }
        .frame(width: 60, height: 55)
        .background(.white.gradient)
        .clipShape(.rect(cornerRadius: 15))
    }
}

#Preview {
    ButtonMovesView(moves: "🖖") { }
}
