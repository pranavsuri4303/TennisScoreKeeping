//
//  MatchScoreingView.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI

struct BasicMatchScoringView: View {
    @Binding var isPresented: Bool
    // Players Names
    @StateObject var vm :MatchVM
    
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
                        Text("Exit")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.trailing)
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
                                Text("\(vm.p1Name)")
                                    .font(.headline)
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
                                Text("\(vm.p2Name)")
                                    .font(.headline)
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
//                    VStack(spacing: 10){
//                        Text("\(vm.p1Sets)")
//                            .font(.title3)
//                            .foregroundColor(Color("green"))
//                            .multilineTextAlignment(.leading)
//                        Text("\(vm.p2Sets)")
//                            .font(.title3)
//                            .foregroundColor(Color("green"))
//                            .multilineTextAlignment(.leading)
//                    }.padding()
                    VStack(spacing: 10){
                        Text("\(vm.p1Games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.p2Games)")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    VStack(spacing: 10){
                        Text("\(vm.ptsScoreTranslator(pts: vm.p1Pts))")
                            .font(.headline)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.ptsScoreTranslator(pts: vm.p2Pts))")
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
                        Text("\(vm.p1Name)")
                            .font(.title3)
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
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding(.horizontal)
                if vm.server == .player1{
                    BasicServerView(vm: vm)
                }else{
                    BasicNonServerView(vm: vm)
                }
            }.padding(.bottom)
            
            VStack{
                HStack{
                    Text("\(vm.p2Name)")
                        .font(.title3)
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
            }.background(Color(.white).opacity(0.1).cornerRadius(8))
            .padding(.horizontal)
            if vm.server == .player2{
                BasicServerView(vm: vm)
            }else{
                BasicNonServerView(vm: vm)
            }
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
    }
}








