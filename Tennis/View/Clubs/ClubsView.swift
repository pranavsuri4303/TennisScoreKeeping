//
//  ClubsView.swift
//  Tennis
//
//  Created by Pranav Suri on 15/7/21.
//

import SwiftUI

struct ClubsView: View {
    @State var showSearch = false
    @State var playerName = ""
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    
                    ZStack{
                        if showSearch{
                            HStack {
                                TextField("Enter players' email...", text: $playerName)
                                    .padding(7)
                                    .padding(.horizontal, 10)
                                    .background(Color(.white).opacity(0.1))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 50)
                                    .autocapitalization(.none)
//                                    .onChange(of: playerName, perform: { value in
//                                        let _ =  downloadingImagesOperations.compactMap({$0}).map{$0.cancel()}
//                                        vm.searchPlayer()
//                                    })
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                            }
                            
                        }else{
                            Text("Players")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                        }
                        HStack{
                            Button(action: {}, label: {
                                Image("plus")
                            }).opacity(0)
                            .disabled(true)
                            Spacer()
                            Button(action: {
                                showSearch.toggle()
                            }, label: {
                                if showSearch{
                                    Image(systemName: "multiply")
                                        .padding()
                                        .foregroundColor(Color("green"))
                                }else{
                                    Image(systemName: "magnifyingglass")
                                        .padding()
                                        .foregroundColor(Color("green"))
                                }
                            })
                        }
                    }
                    if playerName == ""{
                        VStack(alignment: .center, spacing: 20){
                            Spacer()
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .foregroundColor(Color("green"))
                                .frame(width: 100, height: 100, alignment: .center)
                            
                            Text("Search for a user using his email...")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
//                    else{
//                        ScrollView{
//                            ForEach(vm.players, id: \.self) { player in
//                                
//                                SearchPlayerRowView(player: player)
//                                
//                            }.padding()
//                            .edgesIgnoringSafeArea(.bottom)
//                        }
//                        
//                    }
                    
                    
                    Spacer()
                }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            }
        }
    }
}

struct ClubsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsView()
    }
}
