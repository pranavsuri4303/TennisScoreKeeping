//
//  CurrentMatchStatistics.swift
//  Tennis
//
//  Created by Pranav Suri on 9/2/21.
//

import SwiftUI

struct CurrentMatchStatistics: View {
    @ObservedObject var vm : MatchVM
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
                        Text("\(vm.P1.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Text("\(vm.P2.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }.padding()
                    Spacer()
                    VStack(spacing: 10){
                        Text("\(vm.P1.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.P2.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding()
            }
            ScrollView(){
                PlayerStatsCard(player: vm.P1)
                PlayerStatsCard(player: vm.P2)
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
                Text("\(player.totalPtsWon)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("First serve %")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("Serve %")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Second serve %")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.pts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Aces")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.pts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
            HStack{
                Text("Double faults")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
                Text("\(player.pts)")
                    .foregroundColor(Color("green"))
                    .font(.headline)
                
            }.padding(.horizontal)
        }

        
    }
}
