//
//  NewMatchView.swift
//  Tennis
//
//  Created by Sameer Suri on 29/1/21.
//

import SwiftUI

struct NewMatchView: View {
    @StateObject var vm = NewMatchViewModel()
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack(alignment: .center, spacing: 15){
                    Text("New Match")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                    Image("welcomeLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //Dynamic Frame...
                        .padding(.all,20)
                        .padding()
                    
                    HStack{
                        Image(systemName: "person")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("PLAYER 1 NAME", text: $vm.playerOneName)
                            .autocapitalization(.none)
                    }
                    .padding(.all)
                    .background(Color.white.opacity(vm.playerOneName == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    HStack{
                        Image(systemName: "person")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        TextField("PLAYER 2 NAME", text: $vm.playerTwoName)
                            .autocapitalization(.none)
                    }
                    .padding(.all)
                    .background(Color.white.opacity(vm.playerTwoName == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    HStack{
                        Text("Server")
                            .foregroundColor(Color.white)
                        Spacer()
                        Picker(selection: $vm.server, label: Text(""), content: {
                                Text("\(vm.playerOneName)").tag(Player.player1)
                                    .foregroundColor(Color.white)
                                Text("\(vm.playerTwoName)").foregroundColor(Color.white).tag(Player.player2)                    })
                            .pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)
                    
                    Picker(selection: $vm.deuceOrNo, label: Text(""), content: {
                            Text("Deuce")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .tag("deuce")
                            Text("Sudden death").tag("noDeuce")
                                .foregroundColor(Color.white)
                            Text("One Deuce").foregroundColor(Color.white).tag("oneDeuce")                    })
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    
                    HStack{
                        VStack{
                            Text("No. of Sets")
                                .foregroundColor(.white)
                        }.padding()
                        Spacer()
                        VStack{
                            Text("Deuce/Sudden Death")
                                .foregroundColor(.white)
                        }.padding()
                    }.padding(.all)
                    Spacer()
                    NavigationLink(
                        destination: MatchScoringView(),
                        label: {
                            Text("Start Match")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color("green"))
                                .clipShape(Capsule())
                        })
                        .opacity(vm.playerOneName != "" && vm.playerTwoName != "" ? 1 : 0.5)
                        .disabled(vm.playerOneName != "" && vm.playerTwoName != "" ? false : true)
                        .alert(isPresented: $vm.alert, content: {
                            Alert(title: Text(""), message: Text(vm.alertMsg), dismissButton: .destructive(Text("Ok")))
                            
                        })
                }
                .background(Color("bg").ignoresSafeArea(.all, edges: .all))
                
            }
            
        }
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView()
    }
}

