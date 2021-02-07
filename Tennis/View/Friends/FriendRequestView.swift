//
//  FriendRequestView.swift
//  Tennis
//
//  Created by Sameer Suri on 5/2/21.
//

//
//  FriendsListView.swift
//  Tennis
//
//  Created by Sameer Suri on 6/2/21.
//

import SwiftUI

struct FriendRequestView: View {
    @Binding var friendRequestPresented : Bool
    @StateObject var friendRequestVM = SendFriendRequestVM()
    var body: some View {
        VStack{
            VStack{
                ZStack{
                    Text("Friends")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    HStack{
                        Button(action: {
                            // Go to Friend Reuests view
                            friendRequestPresented.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("green"))
                                Text("Back")
                                    .foregroundColor(Color("green"))
                            }
                        }).padding()
                        Spacer()
                    }.padding(.horizontal)
                }
            }
            ////             If list of friends is empty then display this
            //            VStack(alignment: .center, spacing: 20){
            //                Spacer()
            //                Image(systemName: "magnifyingglass.circle")
            //                    .resizable()
            //                    .foregroundColor(Color("green"))
            //                    .frame(width: 100, height: 100, alignment: .center)
            //                Text("What are you waiting for?!")
            //                    .font(.headline)
            //                    .foregroundColor(.white)
            //                    .multilineTextAlignment(.center)
            //                    .lineLimit(1)
            //                    .padding(.horizontal)
            //                Text("Go to the Players tab now to search for users and add them as friends...")
            //                    .font(.headline)
            //                    .foregroundColor(.white)
            //                    .multilineTextAlignment(.center)
            //                    .lineLimit(2)
            //                    .padding()
            //                Spacer()
            //            }
            ///     Else display below ScrollView
            ScrollView(){
                // Insert list of friends here with navigation link to their profile similar to players search
                ForEach(friendRequestVM.requestsUsers , id : \.self) { player in
                    FriendRequestCell(player: player, sendFriendRequestVM: self.friendRequestVM)
                }
            }.padding(.horizontal)
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .onAppear{
            self.friendRequestVM.getPendingRequests()
        }
        
    }
    
    
}
struct FriendRequestCell : View {
    let playerModel : PlayerModel
    @ObservedObject var sendFriendRequestVM : SendFriendRequestVM
    
    
    @ObservedObject var searchPlayerVM : SearchPlayerVM
    init(player : PlayerModel , sendFriendRequestVM : SendFriendRequestVM) {
        self.searchPlayerVM = SearchPlayerVM(player: player)
        self.sendFriendRequestVM = sendFriendRequestVM
        playerModel = player
    }
    var body: some View{
        
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
            Text(playerModel.name)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            HStack(spacing: 10){
                Button(action: {
                    sendFriendRequestVM.acceptFriendRequest(senderUserID: playerModel.uid)
                    
                }, label: {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(Color(.green))
                        .padding()
                })
                Button(action: {
                    sendFriendRequestVM.declintFriendRequest(senderUserID: playerModel.uid)
                }, label: {
                    Image(systemName: "xmark.octagon.fill")
                        .foregroundColor(Color(.red))
                        .padding()
                })
            }

            
        }.padding(.all)
        .background(Color(.white).opacity(0.1).cornerRadius(8))
        .edgesIgnoringSafeArea(.all)
        .onDisappear {
            
        }
    }
}
