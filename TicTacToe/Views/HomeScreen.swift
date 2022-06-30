//
//  HomeScreen.swift
//  TicTacToe
//
//  Created by Divyansh Dwivedi on 05/05/22.
//

import SwiftUI

struct HomeScreen: View {
    @State var animate: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("HomeImg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(" Let The Fun Begin!! ")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                        .border(Color.white, width: 5)
                        .font(.system(size: 70))
                        .shadow(color: Color("shadowcolor"),
                                radius: 4,
                                x: 6.5,
                                y: 6.5)
                    
                        Divider()
                    
                    NavigationLink(destination: GameView(), label: {
                        Image(systemName: "play.circle")
                            .padding(.top)
                            .font(.system(size: 160))
                            .foregroundColor(Color.white)
                            .shadow(color: Color("shadow"),
                                    radius: animate ? 30:10 ,
                                    x: 6.5,
                                    y: 6.5)
                            .scaleEffect(animate ? 1.1 : 0.5)
                            .offset(y: animate ? -7 : 0)
                    }) .padding(.horizontal, animate ? 30:70)
                }.onAppear(perform: addAnimation)
            }

        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation
                            .easeInOut(duration: 2.0)
                            .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
