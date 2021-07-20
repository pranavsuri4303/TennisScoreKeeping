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
                        
                        HStack(alignment: .center, spacing: nil, content: {
                            if showSearch{
                                TextField("Enter clubs' email...", text: $playerName)
                                    .padding(.init(top:5, leading: 10,bottom:5, trailing: 10))
                                    .background(Color(.white).opacity(0.1))
                                    .cornerRadius(8)
                                    .padding(.horizontal,40)
                                    .autocapitalization(.none)
//                                    .onChange(of: playerName, perform: { value in
//                                        let _ =  downloadingImagesOperations.compactMap({$0}).map{$0.cancel()}
//                                        vm.searchPlayer()
//                                    })
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                            }else{
                                Text("Clubs")
                                    .fontWeight(.heavy)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                        }).padding(.horizontal)

                        HStack(alignment: .center, spacing: nil, content: {
                            Spacer()
                            Button(action: {
                                showSearch.toggle()
                            }, label: {
                                if showSearch{
                                    Image(systemName: "multiply")
                                        .font(.title2)
                                        .foregroundColor(Color("green"))
                                }else{
                                    Image(systemName: "magnifyingglass")
                                        .font(.title2)
                                        .foregroundColor(Color("green"))
                                }
                            })
                        }).padding(.horizontal)
                    }.padding(.bottom, 10)

                    Spacer()
//                    if playerName == ""{
                        VStack(alignment: .center, spacing: 20){
                            Spacer()
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .foregroundColor(Color("green"))
                                .frame(width: 100, height: 100, alignment: .center)
                            
                            Text("Search for a club using their unique Club ID...")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
//                    }
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
