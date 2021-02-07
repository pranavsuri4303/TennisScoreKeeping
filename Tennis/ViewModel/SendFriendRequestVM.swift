//
//  SendFriendRequestVM.swift
//  Tennis
//
//  Created by Hossam on 06/02/2021.
//

import Foundation
import Combine
import Firebase


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
    case friend
    case pending
    case notFriend
    
}
class SendFriendRequestVM : ObservableObject {
   private var subscribtions : Set<AnyCancellable> = []
    let currentUserID : String = Auth.auth().currentUser!.uid
    @Published var buttonTitle : String = FriendshipStatus.notFriend.rawValue
    @Published var requestsUsers : [PlayerModel] = []
    @Published var friendsList : [PlayerModel] = []
    var currentStatus = FriendshipStatus.notFriend{
        didSet{
            switch currentStatus {
        case .friend: buttonTitle =  "Friend"
        case .notFriend: buttonTitle = "Send Friend Request"
        case .pending :  buttonTitle = "Pending Request"
        }}
    }

     func setFriendshipStatus(recieverUserID : String){
        print(currentUserID)
        var currentStatus = FriendshipStatus.notFriend
        Firestore.firestore().collection("users").document(recieverUserID).addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error)
                return
            }
            if let data = snapshot?.data(){
                if let friends = data["friends"] as? [String: String] , friends.keys.contains(self.currentUserID) ,  let friendship = friends[self.currentUserID]  , let friendshipStatus = FriendshipStatus.init(rawValue: friendship) {
                    switch friendshipStatus {
                    case .friend: currentStatus = .friend
                    case .pending: currentStatus = .pending
                    default : break
                    }
                }else {
                    currentStatus = .notFriend
                    
                }
                self.currentStatus = currentStatus
            }
        }
        
       
        
    }
    
    
    
    func sendFriendRequest(recieverUserID : String){
        print(recieverUserID)
        
        Firestore.firestore().collection("users").document(recieverUserID).setData(["friends": [currentUserID:FriendshipStatus.pending.rawValue]], merge: true) { (error) in
            if let error = error {
                print(error)
                return
            }
            
            self.currentStatus = .pending
        }
    }
    
    func acceptFriendRequest(senderUserID : String){
        Firestore.firestore().collection("users").document(senderUserID).setData(["friends": [currentUserID:FriendshipStatus.friend.rawValue]], merge: true) { (error) in
            if let error = error {
                print(error)
                return
            }
            
            Firestore.firestore().collection("users").document(self.currentUserID).setData(["friends": [senderUserID:FriendshipStatus.friend.rawValue]], merge: true) { (error) in
                if let error = error {
                    print(error)
                    return
                }
                self.requestsUsers.removeAll(where: {$0.uid == senderUserID})
            
                
        }
    }
    }
    
    func declineFriendRequest(senderUserID : String){
        Firestore.firestore().collection("users").document(currentUserID).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            
            if var data  = snapshot?.data() , var friends = data["friends"] as? [String:String] {
                friends.removeValue(forKey: senderUserID)
                data.updateValue(friends, forKey: "friends")
                Firestore.firestore().collection("users").document(self.currentUserID).setData(data) { (error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    self.requestsUsers.removeAll(where: {$0.uid == senderUserID})
                }
            }
        }
        
    }
    
    func getPendingRequests(){
        requestsUsers = []
        Firestore.firestore().collection("users").document(currentUserID).addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = snapshot?.data(){
                if let friends = data["friends"] as? [String: String]  {
                    friends.filter { $0.value == FriendshipStatus.pending.rawValue }.map(\.key).forEach { (userID) in
                        
                        Firestore.firestore().collection("users").document(userID).getDocument { (userSnapshot, error) in
                            
                            if let error = error {
                                print(error)
                                
                            }
                           
                            
                            if let data = userSnapshot?.data() {
                    
                                if let name = data["name"] as? String ,
                                   let uid = data["uid"] as? String
                                    {
                                    let playerModel = PlayerModel(uid: uid, name: name, gender: "", imagePath: (data["imageProfilePath"] as? String) ?? "", nationality: "")
                                    self.requestsUsers.append(playerModel)
                                    
                                }
                            }
                        }
                    }

                }
            }
        }
    }
    
    
    func getFriendsList(){
        friendsList = []
        Firestore.firestore().collection("users").document(currentUserID).addSnapshotListener { (snapshot, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = snapshot?.data(){
                if let friends = data["friends"] as? [String: String]  {
                    friends.filter { $0.value == FriendshipStatus.friend.rawValue }.map(\.key).forEach { (userID) in
                        
                        Firestore.firestore().collection("users").document(userID).getDocument { (userSnapshot, error) in
                            
                            if let error = error {
                                print(error)
                                
                            }
                           
                            
                            if let data = userSnapshot?.data() {
                    
                                if let name = data["name"] as? String ,
                                    let uid = data["uid"] as? String
                                    {
                                    let playerModel = PlayerModel(uid: uid, name: name, gender: "", imagePath: (data["imageProfilePath"] as? String) ?? "", nationality: "")
                                    self.friendsList.append(playerModel)
                                    
                                }
                            }
                        }
                    }

                }
            }
        }
    }
    
    
}
