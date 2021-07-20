//
//  FriendsListView.swift
//  Tennis
//
//  Created by Pranav Suri on 6/2/21.
//

import SwiftUI

struct FriendRequestView: View {
    @Binding var friendRequestPresented : Bool
    @StateObject var friendRequestVM = FriendsVM()
    var body: some View {
        VStack{
            HStack{
                ZStack{
                    Text("Friends")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    HStack{
                        Button(action: {
                            // Go to Friends List view
                            friendRequestPresented.toggle()
                        }, label: {
                            HStack{
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("green"))
                                Text("Back")
                                    .foregroundColor(Color("green"))
                            }
                        })
                        Spacer()
                    }
                }
            }.padding(.horizontal)
            
            ScrollView(){
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
    @ObservedObject var sendFriendRequestVM : FriendsVM
    @ObservedObject var searchPlayerVM : SearchPlayerVM
    
    init(player : PlayerModel , sendFriendRequestVM : FriendsVM) {
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
                    sendFriendRequestVM.declineFriendRequest(senderUserID: playerModel.uid)
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
