//
//  NewMatchView.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI

struct NewMatchView: View {
    @StateObject var vm = MatchVM()
    @State var matchScorerIsPresented = false
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack(spacing: 15){
                    VStack(alignment: .leading){
                        Text("New Match")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                    }
                    
                    Image("welcomeLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //Dynamic Frame...
                        .padding(.all,20)
                        .padding()
                    
                    HStack{
                        Image(systemName: "1.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("PLAYER 1 NAME", text: $vm.p1Name)
                            .autocapitalization(.words)
                    }
                    .padding(.all)
                    .background(Color.white.opacity(vm.p1Name == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    HStack{
                        Image(systemName: "2.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        TextField("PLAYER 2 NAME", text: $vm.p2Name)
                            .autocapitalization(.words)
                    }
                    .padding(.all)
                    .background(Color.white.opacity(vm.p2Name == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    HStack{
                        Text("Server")
                            .foregroundColor(Color.white)
                        Spacer()
                        Picker(selection: $vm.server, label: Text(""), content: {
                                Text("\(vm.p1Name)")
                                    .tag(Player.player1)
                                    .foregroundColor(Color.white)
                                Text("\(vm.p2Name)")
                                    .tag(Player.player2)
                                    .foregroundColor(Color.white)
                            
                        })
                            .pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)
                    
                    Picker(selection: $vm.deuceOrNo, label: Text(""), content: {
                            Text("Deuce")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .tag(Deuce.deuce)
                            Text("Sudden death").tag(Deuce.noDeuce)
                                .foregroundColor(Color.white)
                            Text("One Deuce").foregroundColor(Color.white).tag(Deuce.oneDeuce)
                    }).pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    Picker(selection: $vm.trackingStyle, label: Text(""), content: {
                            Text("Basic")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .tag(Tracking.basic)
                            Text("Advanced").tag(Tracking.advanced)
                                .foregroundColor(Color.white)
                        Text("Expert").foregroundColor(Color.white).tag(Tracking.expert)
                    }).pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    HStack{
                        Text("No. of Sets")
                            .foregroundColor(Color.white)
                        Spacer()
                        Picker(selection: $vm.noOfSets, label: Text(""), content: {
                                Text("1")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .tag(1)
                                Text("3").tag(3)
                                    .foregroundColor(Color.white)
                        }).pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)

                    Spacer()
                    Button(action: {
                        matchScorerIsPresented.toggle()
                        print(vm.p2Name)
                        
                    }, label: {
                        Text("START MATCH")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .fullScreenCover(isPresented: $matchScorerIsPresented, content: {
                        if vm.trackingStyle == .basic{
                            BasicMatchScoringView(isPresented: $matchScorerIsPresented, vm: vm)
                        } else if vm.trackingStyle == .advanced{
                            AdvancedMatchScoringView(isPresented: $matchScorerIsPresented, vm: vm)
                        }else{
                            ExpertMatchScoringView(isPresented: $matchScorerIsPresented, vm: vm)
                        }
                        
                    })
                    .opacity(vm.p2Name != "" ? 1 : 0.5)
                    .disabled(vm.p2Name != "" ? false : true)
                    .alert(isPresented: $vm.alert, content: {
                        Alert(title: Text("Error"), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })
                }
                .background(Color("bg").ignoresSafeArea(.all, edges: .all))
                if vm.isLoading{
                    LoadingScreenView()
                }
            }
            
        }
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView()
    }
}

