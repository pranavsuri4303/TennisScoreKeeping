//
//  PlayersView.swift
//  Tennis
//
//  Created by Sameer Suri on 31/1/21.
//

import SwiftUI

struct PlayersSearchView: View {
    @State var showSearch = false
    @StateObject var vm = PlayersVM()
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack{
                    
                    ZStack{
                        if showSearch{
                            HStack {
                                TextField("Enter players' email...", text: $vm.playerName)
                                    .padding(7)
                                    .padding(.horizontal, 10)
                                    .background(Color(.white).opacity(0.1))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 50)
                                    .autocapitalization(.none)
                                    .onChange(of: vm.playerName, perform: { value in
                                        vm.searchPlayer()
                                    })
                                    .foregroundColor(.white)
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
                    if vm.playerName == ""{
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
                    }else{
                        ScrollView{
                            ForEach(vm.players, id: \.self) { player in
                                        SearchPlayerRowView(player: player)
                                 
                        }.padding()
                        .edgesIgnoringSafeArea(.bottom)
                        }
                        
                    }
                    
                    
                    Spacer()
                }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
            }
        }
    }
}


struct SearchPlayerRowView : View {
    let player : PlayerModel
    @State var isNavigationLinkState : Bool = false
    @ObservedObject var searchPlayerVM : SearchPlayerVM
    
    init(player : PlayerModel) {
        self.player = player
        self.searchPlayerVM = SearchPlayerVM(player: player)
    }
    
    var body: some View{
        NavigationLink(
            destination: Text("Destination"),
            label: {
                HStack(alignment: .center){
                    if let downloadedImage = searchPlayerVM.downloadedImage {
                        Image(uiImage: downloadedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                    else {
                        Image("\(player.gender)")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaledToFit()
                    }
                    
                    Text("\(player.name)")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color("green"))
                }.padding(.all)
                .background(Color(.white).opacity(0.1).cornerRadius(8))
                .edgesIgnoringSafeArea(.all)
                .onDisappear {
                    searchPlayerVM.operation?.cancel()
                }
            })
    }
}
