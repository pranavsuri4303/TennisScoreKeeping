//
//  FriendsListView.swift
//  Tennis
//
//  Created by Sameer Suri on 6/2/21.
//

import SwiftUI

struct FriendsListView: View {
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
                            // Go to Friend Reuests view
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color("green"))
                        })
                    }.padding(.all)
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
                FriendsListCell()
                FriendsListCell()
                FriendsListCell()
                FriendsListCell()
                FriendsListCell()
                FriendsListCell()
                FriendsListCell()
            }.padding(.horizontal)
            Spacer()
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
    }
    
    
}
struct FriendsListCell : View {
    
    var body: some View{
        NavigationLink(
            destination: Text("Friend Profile View"),
            label: {
                HStack(alignment: .center){
                    
//                    if let downloadedImage = searchPlayerVM.downloadedImage {
//                        Image(uiImage: downloadedImage)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .clipShape(Circle())
//                            .frame(width: 50, height: 50, alignment: .center)
//                    }
//                    else {
                        Image("Male")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaledToFit()
//                    }
                        Text("Friend Name")
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
