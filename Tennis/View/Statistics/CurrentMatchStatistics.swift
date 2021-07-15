//
//  CurrentMatchStatistics.swift
//  Tennis
//
//  Created by Sameer Suri on 9/2/21.
//

import SwiftUI

struct CurrentMatchStatistics: View {
    @State var p1Stats : Player
    @State var p2Stats : Player
    @State var winner : String
    @Binding var selfIsPresented : Bool
    var body: some View {
        VStack{
            HStack{
                Text("\(winner) won!")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer()
            }.padding([.top, .horizontal])
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("\(p1Stats.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Text("\(p2Stats.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }.padding()
                    Spacer()
                    VStack(spacing: 10){
                        Text("\(p1Stats.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(p2Stats.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding()
            }
            ScrollView(){
                PlayerStatsCard(player: p1Stats)
                PlayerStatsCard(player: p2Stats)
            }.edgesIgnoringSafeArea(.all)
            Spacer()
            
        }.background(Color("bg").edgesIgnoringSafeArea(.all))
    }
}




struct PlayerStatsCard: View {
    @State var player : Player
    
    var body: some View{
        VStack(spacing: 10){
            HStack{
                Text("\(player.name)")
                    .foregroundColor(.white)
                    .font(.title2)
                Spacer()
            }.padding()
            HStack{
                Text("Points won")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.totalPts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("First serve %")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\((player.firstServesIn/player.totalFirstServes)*100)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Second serve %")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.totalPts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Aces")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.totalPts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Double faults")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.totalPts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
        }

        
    }
}
