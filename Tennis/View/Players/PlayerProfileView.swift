//
//  PlayerProfileView.swift
//  Tennis
//
//  Created by Sameer Suri on 3/2/21.
//

import SwiftUI

struct PlayerProfileView: View {
    let playerModel : PlayerModel
    @StateObject var sendFriendRequestVM = SendFriendRequestVM.init()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                
                GeometryReader{reader in
                    
                    // Type 2 Parollax....
                    
                    if reader.frame(in: .global).minY > -480 {
                        if let playerImage = playerModel.downloadedImage {
                            Image(uiImage: playerImage)
                                .resizable()
                                .background(Color.blue)
                                .padding(.top,75)
                                .aspectRatio(contentMode: .fill)
                                // moving View Up....
                                .offset(y: -reader.frame(in: .global).minY)
                                // going to add parallax effect....
                                .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                        }else {
                            Image(playerModel.gender == "Male" ? "Male":"Female" )
                                .resizable()
                                .padding(.top,75)
                                .aspectRatio(contentMode: .fill)
                                // moving View Up....
                                .offset(y: -reader.frame(in: .global).minY)
                                // going to add parallax effect....
                                .frame(width: UIScreen.main.bounds.width, height:  reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 480 : 480)
                            
                        }
                    }
                }
                .frame(height: 480)
                VStack(alignment: .leading,spacing: 15){
                    Text(playerModel.name )
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Text(playerModel.gender )
                        .font(.subheadline)
                        .foregroundColor(.white)
                    HStack{
                        Spacer()
                        Button(action: {
                            sendFriendRequestVM.sendFriendRequest(recieverUserID: playerModel.uid)
                            
                        }, label: {
                            Text(sendFriendRequestVM.buttonTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color("green"))
                                .clipShape(Capsule())
                        }).padding()
                        .disabled(sendFriendRequestVM.currentStatus == .friend || sendFriendRequestVM.currentStatus == .pending)
                        Spacer() 
                    }
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color("bg"))
                .cornerRadius(20)
                .offset(y: -30)
                .edgesIgnoringSafeArea(.horizontal)
            })
            .edgesIgnoringSafeArea(.all)
            .background(Color("bg").edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)

        }
        .navigationTitle(Text("\(playerModel.name)"))
        .foregroundColor(Color("bg"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            sendFriendRequestVM.setFriendshipStatus(recieverUserID: playerModel.uid)
        })
    }
}

