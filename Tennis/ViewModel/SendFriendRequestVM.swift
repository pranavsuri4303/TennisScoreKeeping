//
//  SendFriendRequestVM.swift
//  Tennis
//
//  Created by Hossam on 06/02/2021.
//

import Foundation
import Combine
import FirebaseFirestore


/**
 
Enum friend , notfirend
 1- get status of freidnship - when viewing friend  get friendship status from Reciever DB to and check if the SENDERID exsist
  if not exist able to send friend request
 if exist check if friends or not
    if friends unfriend
    if notfriend remove request 
    
 2-
 get a list of all frineships with status = friend
 
 3- send friend request
    1- to send friend request you will go to the Receiver user UID and update its child with , Sender ID ,  friend status notfriends
      2- this will be presented in freidrequestScreens wit accept or decline
       3- if accepted : 1- changes in RECIEVER  UId  and :- Friends  SENDUID status friend
                        2- add RECEIVERUID to SENDER FriendsList  with status friend
       4- if declient :- 1- remove SenderUID from ReceiverFriendsDIC

 
 */
enum FriendshipStatus : String {
    case pending
    case none
    case friend
}
class SendFriendRequestVM : ObservableObject {
   private var subscribtions : Set<AnyCancellable> = []
    @Published var buttonTitle : String = FriendshipStatus.none.rawValue
    private var friendUserID = PassthroughSubject<String , Never>()
    
    init() {
        setFriendshipStatus()
    }
    func setFriendUserID(_ userID : String){
        sendFriendRequest(userID: userID)
    }
    
    private func setFriendshipStatus(){
        friendUserID.map { userID in
            print(userID)
            Firestore.firestore().collection("users").document(userID).getDocument { (snap, error) in
                print(snap?.data())
                #warning("Implement request Status")
            }
        }
        .sink(receiveValue: {
            
        })
        .store(in: &subscribtions)
    }
    
    
    func sendFriendRequest(userID : String){
        
        Firestore.firestore().collection("users").document("0mpkoMN2TrRfB5vUGRae0H4F3VW2").setData(["friends": ["1450S":"R"]], merge: true)
    }
    
    
    
    
}
