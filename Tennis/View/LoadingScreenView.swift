//
//  Loading Screen.swift
//  Login_Face_ID
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI

struct LoadingScreenView: View {
    @State var animate = false
    var body: some View {
        
        ZStack{
            
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all, edges: .all)
            
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color("green"),lineWidth: 10)
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .padding(40)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
        .onAppear(perform: {
            withAnimation(Animation.linear.speed(0.6).repeatForever(autoreverses: false)){
                animate.toggle()
            }
        })
    }
}

