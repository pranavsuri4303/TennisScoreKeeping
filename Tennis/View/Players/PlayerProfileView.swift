//
//  PlayerProfileView.swift
//  Tennis
//
//  Created by Sameer Suri on 3/2/21.
//

import SwiftUI

struct PlayerProfileView: View {
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                
                GeometryReader{reader in
                    
                    // Type 2 Parollax....
                    
                    if reader.frame(in: .global).minY > -480 {
                        Image("Male")
                            .resizable()
                            .padding(.top,75)
                            .aspectRatio(contentMode: .fill)
                            // moving View Up....
                            .offset(y: -reader.frame(in: .global).minY)
                            // going to add parallax effect....
                            .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                    }
                }
                .frame(height: 480)
                VStack(alignment: .leading,spacing: 15){
                    Text("Player Name")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Player Gender")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.top,5)
                    HStack{
                        Text("")
                        Spacer()
                    }
                    

                    
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color("bg"))
                .cornerRadius(20)
                .offset(y: 75)
                .edgesIgnoringSafeArea(.horizontal)
            })
            .edgesIgnoringSafeArea(.all)
            .background(Color("bg").edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
        .navigationTitle(Text("Player name"))
        .foregroundColor(Color("bg"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

