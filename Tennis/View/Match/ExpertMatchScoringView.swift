//
//  ExpertMatchScoringView.swift
//  Tennis
//
//  Created by Pranav Suri on 1/2/21.
//

import SwiftUI

struct ExpertMatchScoringView
: View {
    @Binding var isPresented: Bool
    // Players Names
    @StateObject var vm :MatchVM
    
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
                Text("Expert")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        VStack{
                            HStack{
                                Text("\(vm.P1.name)")
                                    .font(.title3)
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
                                    .font(.title3)
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
                        Text("\(vm.P1.games)")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.P2.games)")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    VStack(spacing: 10){
                        Text("\(vm.ptsToScore(pts: vm.P2.pts))")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                        Text("\(vm.ptsToScore(pts: vm.P2.pts))")
                            .font(.title3)
                            .foregroundColor(Color("green"))
                            .multilineTextAlignment(.leading)
                    }.padding()
                    
                }.background(Color(.white).opacity(0.1).cornerRadius(8))
                .padding()
            }
            VStack{
                HStack{
                    Text("\(vm.P1.name)")
                        .font(.title2)
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
            HStack{
                VStack(){
                    Button(action: {}, label: {
                        Spacer()

                        Text("SERVE IN")
                            .font(.headline)
                            .foregroundColor(Color("blue"))
                            .multilineTextAlignment(.center)
                        Spacer()

                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color("Orange").opacity(0.5).cornerRadius(8))
                VStack(){
                        Button(action: {}, label: {
                            Spacer()

                            Text("FIRST FAULT")
                                .font(.headline)
                                .foregroundColor(Color("blue"))
                                .multilineTextAlignment(.center)
                            Spacer()

                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color("Orange").opacity(0.5).cornerRadius(8))
                VStack(){
                        Button(action: {}, label: {
                            Spacer()

                            Text("ACE")
                                .font(.headline)
                                .foregroundColor(Color("blue"))
                                .multilineTextAlignment(.center)
                            Spacer()

                        })
                        .edgesIgnoringSafeArea(.all)
                    }.frame(height: 100, alignment: .center)
                    .background(Color("Orange").opacity(0.5).cornerRadius(8))
            }.padding(.horizontal)
            VStack{
                HStack{
                    Text("\(vm.P2.name)")
                        .font(.title2)
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
            HStack{
                VStack(){
                    Button(action: {}, label: {
                        Spacer()
                        Text("POINT WON")
                            .font(.headline)
                            .foregroundColor(Color("blue"))
                            .multilineTextAlignment(.center)
                        Spacer()
                    })
                    .edgesIgnoringSafeArea(.all)
                }.frame(height: 100, alignment: .center)
                .background(Color("Orange").opacity(0.5).cornerRadius(8))

            }.padding(.horizontal)
            
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
        
    }
}
