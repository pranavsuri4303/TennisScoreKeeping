//
//  MatchScoreingView.swift
//  Tennis
//
//  Created by Pranav Suri on 29/1/21.
//

import SwiftUI

struct BasicMatchScoringView: View {
    @Binding var isPresented: Bool
    // Players Names
    @StateObject var vm = MatchVM()
    
    @State var dashboardIsPresented = false
    
    var body: some View {
        VStack{
            ZStack{
                Text("Basic")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                HStack{
                    Spacer()
                    Button(action: {
                        dashboardIsPresented.toggle()
                    }, label: {
                        Image("more")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(Color("green"))
                    }).fullScreenCover(isPresented: $dashboardIsPresented, content: {
                        Home()
                    }).padding(.all)
                    
                }
            }
            
            VStack{
                

                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        VStack{
                            HStack{
                                Text("\(vm.P1.name)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                if vm.server == .p1 {
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
                                Text("\(vm.P2.name)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                if vm.server == .p2 {
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
                        Text("\(vm.P1.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.P2.games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    VStack(spacing: 10){
                        Text("\(vm.ptsToScore(pts: vm.P1.pts))")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.ptsToScore(pts: vm.P2.pts))")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding()
            }
            VStack{
                VStack{
                    HStack{
                        Text("\(vm.P1.name)")
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        if vm.server == .p1 {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                        } else {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(Color("green"))
                                .hidden()
                        }
                        
                    }.padding()
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding(.horizontal)
                if vm.server == .p1{
                    BasicServerView(vm: vm)
                }else{
                    BasicNonServerView(vm: vm)
                }
            }.padding(.bottom)
            
            VStack{
                HStack{
                    Text("\(vm.P2.name)")
                        .font(.title3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if vm.server == .p2 {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(Color("green"))
                            .hidden()
                    }
                }.padding()
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            if vm.server == .p2{
                BasicServerView(vm: vm)
            }else{
                BasicNonServerView(vm: vm)
            }
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $vm.matchIsOver, content: {
            CurrentMatchStatistics(vm: vm, winner: vm.winner == .p1 ? "\(vm.P1.name)" : "\(vm.P2.name)", selfIsPresented: $vm.matchIsOver)
        })
    }
}








