//
//  AlertView.swift
//  TicTacToe
//
//  Created by Divyansh Dwivedi on 05/05/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    var buttonTitle: Text
}

struct AlertView {

            static let humanWin = AlertItem(title: Text("You Win"),
                                            message: Text("You Are So Smart. You Helped The Bug To Escape."),
                                            buttonTitle: Text("Hell Yeah"))
            
           static let computerwin = AlertItem(title: Text("You Lost"),
                                        message: Text("Lightning Hit The Bug"),
                                        buttonTitle: Text("Beat The Light"))
            
           static  let draw = AlertItem(title: Text("Draw"),
                                 message: Text("What A Battle Of Wits."),
                                 buttonTitle: Text("Try Again"))
            
        
}



