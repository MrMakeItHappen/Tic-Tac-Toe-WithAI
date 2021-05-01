//
//  SelectionIndicator.swift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import SwiftUI

struct SelectionIndicator: View {
    var systemImageName: String
    var color: Color
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(color)
    }
}

struct SelectionIndicator_Previews: PreviewProvider {
    static var previews: some View {
        SelectionIndicator(systemImageName: "xmark", color: Color.red)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
