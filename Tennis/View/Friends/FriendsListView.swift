//
//  FriendsListView.swift
//  Tennis
//
//  Created by Sameer Suri on 6/2/21.
//

import SwiftUI

struct FriendsListView: View {
    @StateObject var friendRequestVM = FriendsVM()
    @State private var goToRequests = false
    var body: some View {
        VStack{
            
            VStack{
                ZStack{
                    Text("Friends")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    HStack{
                        Spacer()
                        Button(action: {
                            goToRequests.toggle()
                        }, label: {
                            if self.friendRequestVM.requestsUsers.count == 0{
                                Image(systemName: "bell")
                                    .foregroundColor(Color("green"))
                            }else{
                                Image(systemName: "bell.badge")
                                    .foregroundColor(Color("green"))
                            }
                            
                        }).fullScreenCover(isPresented: $goToRequests, content: {
                            FriendRequestView(friendRequestPresented: $goToRequests)
                        })
                    }.padding(.all)
                }
            }

            if friendRequestVM.friendsList.count == 0{
                VStack(alignment: .center, spacing: 20){
                    Spacer()
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .foregroundColor(Color("green"))
                        .frame(width: 100, height: 100, alignment: .center)
                    Text("What are you waiting for?!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .padding(.horizontal)
                    Text("Go to the Players tab now to search for users and add them as friends...")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding()
                    Spacer()
                }
            }else{
                ScrollView(){
                    ForEach(friendRequestVM.friendsList , id : \.self) { (player) in
                        FriendsListCell(player: player)
                    }
                }.padding(.horizontal)
                Spacer()
            }

        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            friendRequestVM.getFriendsList()
            friendRequestVM.getPendingRequests()
        })
        
    }
    
    
}
struct FriendsListCell : View {
    @ObservedObject var searchPlayerVM : SearchPlayerVM
    let player : PlayerModel
    
    init(player : PlayerModel) {
        self.searchPlayerVM = SearchPlayerVM(player: player)
        self.player = player
    }
    var body: some View{
        NavigationLink(
            destination: Text("Friend Profile View"),
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
                        Image("Male")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaledToFit()
                    }
                    Text(player.name)
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
                    
                }
            })
    }
}
