//
//  GamePieceView.swift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import SwiftUI

struct GamePieceView: View {
    var proxy: GeometryProxy
    var color: Color
    
    var body: some View {
        Circle()
            .foregroundColor(color)
            .opacity(0.5)
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
    }
}

struct GamePieceView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            GamePieceView(proxy: geometry, color: Color.blue)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
