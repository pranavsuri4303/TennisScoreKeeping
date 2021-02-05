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
    @State var selectionP1 = 0
    @State var selectionP2 = 0
    @State var p1Other = false
    @State var p2Other = false
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
                    Group{
                        HStack{
                            Image(systemName: "1.circle")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 35)
                            if p1Other{
                                TextField("Player 1 Name", text: $vm.P1.name)
                                    .autocapitalization(.words)
                            }else{
                                TextFieldWithInputView(data: Friends().list2, placeholder: "Select Player 1", selectionIndex: self.$selectionP1, selectedText: $vm.P1.name)
                                    .frame(height: 0)
                            }
                        }
                        .padding(.all)
                        .background(Color(.white).opacity(vm.P1.name == "" ? 0.02 : 0.12))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        
                        VStack(alignment: .center){
                            Button(action: {
                                self.p1Other.toggle()
                                vm.P1.name = ""
                            }, label: {
                                if p1Other{
                                    Text("Recording for yourself or a friend?")
                                        .font(.subheadline)
                                        .foregroundColor(Color("green"))
                                }else{
                                    Text("Recording for someone else?")
                                        .font(.subheadline)
                                        .foregroundColor(Color("green"))
                                }
                            })
                        }
                        HStack{
                            Image(systemName: "2.circle")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 35)
                            if p2Other{
                                TextField("Player 2 Name", text: $vm.P2.name)
                                    .autocapitalization(.words)
                            }else{
                                TextFieldWithInputView(data: Friends().list, placeholder: "Select Player 2", selectionIndex: self.$selectionP2, selectedText: $vm.P2.name)
                                    .frame(height: 0)
                            }
                        }
                        .padding()
                        .background(Color(.white).opacity(vm.P2.name == "" ? 0.02 : 0.12))
                        .cornerRadius(15)
                        .padding(.horizontal)
                        VStack(alignment: .center){
                            Button(action: {
                                self.p2Other.toggle()
                                vm.P2.name = ""
                            }, label: {
                                if p2Other{
                                    Text("Player in your friends list?")
                                        .font(.subheadline)
                                        .foregroundColor(Color("green"))
                                }else{
                                    Text("Player outside your friends list?")
                                        .font(.subheadline)
                                        .foregroundColor(Color("green"))
                                }
                            })
                        }
                    }

                    HStack{
                        Text("Server")
                            .foregroundColor(.white)
                        Spacer()
                        Picker(selection: $vm.server, label: Text(""), content: {
                            Text("\(vm.P1.name)")
                                    .tag(PlayerType.p1)
                                    .foregroundColor(.white)
                            Text("\(vm.P2.name)")
                                    .tag(PlayerType.p2)
                                    .foregroundColor(.white)
                            
                        })
                            .pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)
                    
                    Picker(selection: $vm.deuceType, label: Text(""), content: {
                            Text("Deuce")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .tag(DeuceType.deuce)
                            Text("Sudden death").tag(DeuceType.noDeuce)
                                .foregroundColor(.white)
                            Text("One Deuce").foregroundColor(Color(.white)).tag(DeuceType.oneDeuce)
                    }).pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    Picker(selection: $vm.trackingStyle, label: Text(""), content: {
                            Text("Basic")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .tag(TrackingType.basic)
                            Text("Advanced").tag(TrackingType.advanced)
                                .foregroundColor(.white)
                        Text("Expert").foregroundColor(Color(.white)).tag(TrackingType.expert)
                    }).pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    HStack{
                        Text("1 Set: First to 6 Games")
                            .foregroundColor(.white)
//                        Spacer()
//                        Picker(selection: $vm.noOfSets, label: Text(""), content: {
//                                Text("1")
//                                    .foregroundColor(.white)
//                                    .multilineTextAlignment(.center)
//                                    .tag(1)
//                                Text("3").tag(3)
//                                    .foregroundColor(.white)
//                        }).pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal)

                    Spacer()
                    Button(action: {
                        matchScorerIsPresented.toggle()
                        print(vm.P2.name)
                        
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
                    .opacity(vm.P2.name != "" ? 1 : 0.5)
                    .disabled(vm.P2.name != "" ? false : true)
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


struct Friends {
    var list = ["",
                "Aldrin",
                "Jemma"]
    var list2 = ["You",
                "Aldrin",
                "Jemma"]
    
}
