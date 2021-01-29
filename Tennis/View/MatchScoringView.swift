//
//  MatchScoreingView.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI

struct MatchScoringView: View {
    @Binding var isPresented: Bool
    @Binding var playerTwoName: String
    @Binding var playerOneName: String
    @Binding var server: Player
    @StateObject var vm = MatchScoringViewModel()
    
    @State var dashboardIsPresented = false
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    dashboardIsPresented.toggle()
                }, label: {
                    Text("Exit")
                        .font(.subheadline)
                        .foregroundColor(Color("green"))
                        .multilineTextAlignment(.trailing)
                }).fullScreenCover(isPresented: $dashboardIsPresented, content: {
                    Home()
                }).padding(.all)
                
            }
            VStack{
                Text("Score")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        VStack{
                            HStack{
                                Text("\(playerOneName)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                if vm.server == .player1 {
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(Color("green"))
                                } else {
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(Color("green"))
                                        .hidden()
                                }
                            }
                        }
                        VStack{
                            HStack{
                                Text("\(playerTwoName)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                if vm.server == .player2 {
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(Color("green"))
                                } else {
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(Color("green"))
                                        .hidden()
                                }
                            }
                            
                        }
                        
                    }.padding()
                    Spacer()
                    VStack(spacing: 10){
                        Text("\(vm.p1GamesScore)")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.p2GamesScore)")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    VStack(spacing: 10){
                        Text("\(vm.ptsScore(of: vm.p1Pts, against: vm.p2Pts))")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.ptsScore(of: vm.p2Pts, against: vm.p1Pts))")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding()
            }
            VStack{
                HStack{
                    Text("\(playerOneName)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if vm.server == .player1 {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                            .hidden()
                    }
                    
                }.padding()
                Button(action: {
                    vm.pointWon(by: .player1)
                }, label: {
                    Text("Player 1")
                })

            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            VStack{
                HStack{
                    Text("\(playerTwoName)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if vm.server == .player2 {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                            .hidden()
                    }
                    
                }.padding()
                Button(action: {
                    vm.pointWon(by: .player2)
                }, label: {
                    Text("Player 2")
                })
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
        
    }
}








