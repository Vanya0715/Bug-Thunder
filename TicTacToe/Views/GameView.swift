//
//  GameView.swift
//  TicTacToe
//
//  Created by Divyansh Dwivedi on 05/05/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var gameVM = GameViewModel()
 

    
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("GameBg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        LazyVGrid(columns: gameVM.columns, spacing: 5) {
                            ForEach(0..<9){ i in
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color("TileColor"))
                                        .frame(width: geometry.size.width/3 - 15,
                                               height: geometry.size.width/3 - 15)
                                        .shadow(color: Color("shadow") , radius: 4, x: 6.5, y: 6.5)
                                    
                                    Image(systemName: gameVM.moves[i]?.indicator ?? "")
                                        .font(.system(size: 60))
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color("textColor"))
                                        .shadow(color: Color("lightShadow"),
                                                radius: 4,
                                                x: 6.5,
                                                y: 6.5)
                                }
                                .onTapGesture {
                                    gameVM.processPlayer(for: i)
                                }
                            }
                        }
                        Spacer()
                    }.disabled(gameVM.isBoardDisabled)
                    .padding()
                    .alert(item: $gameVM.alertItem, content: {
                        alertItem in Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                            gameVM.resetGame() }))
                        })
                }
            }
        }
    }
    
    
    
    

    
}





enum Player {
    case human
    case computer
}

struct Move {
    let player: Player
    var boardIndex: Int
    
    var indicator: String {
        return player == .human ? "ladybug" : "bolt"
    }
    
}

