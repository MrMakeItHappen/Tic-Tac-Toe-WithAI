//
//  Alerts.swift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static var humanWin = AlertItem(title: Text("You win!"),
                             message: Text("You are the smartest person on the planet!"),
                             buttonTitle: Text("Play Again?"))
    
    static var computerWin = AlertItem(title: Text("You Lost 🙃"),
                             message: Text("I'm a super AI, what'd you expect?"),
                             buttonTitle: Text("Play Again"))
    
    static var draw = AlertItem(title: Text("Draw!"),
                             message: Text("A legendary battle has expired."),
                             buttonTitle: Text("Rematch"))
}
