//
//  HomeView.swift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            viewModel.boardColor.ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { index in
                            ZStack {
                                GamePieceView(proxy: geometry, color: viewModel.pieceColor)
                                
                                SelectionIndicator(systemImageName: viewModel.moves[index]?.indicator ?? "", color: viewModel.selectionColor)
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: index)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isGameBoardDisabled)
                .padding()
                //Reset game.
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                    }))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


