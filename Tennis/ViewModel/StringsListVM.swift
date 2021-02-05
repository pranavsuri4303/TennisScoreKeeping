//
//  StringsListViewModel.swift
//  Tennis
//
//  Created by Hossam on 30/01/2021.
//


import Firebase
import Combine

struct StringModel : Hashable  {
    let id = UUID.init()
    let cross : Int
    let date : Date
    let mains : Int
    let name : String
}
class StringsListVM: ObservableObject {
    @Published var strings : [StringModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getData()
    }
    func getData( ){
        Firestore.firestore().collection("users").document(Firebase.Auth.auth().currentUser!.uid).addSnapshotListener { (snap, error) in
            self.strings.removeAll()
            if let data = snap?.data() , let stringsArray  = data["strings"] as? [Any]  {
                stringsArray.publisher.compactMap {
                    if  let stringValue = $0 as? [String:Any]{
                        if  let date = (stringValue["date"] as? Timestamp)?.dateValue(),
                        let cross = stringValue["cross"] as? Int,
                        let mains = stringValue["mains"] as? Int,
                        let name = stringValue["name"] as? String{
                
                        return StringModel(cross: cross, date: date, mains: mains, name: name)
                        
                       }
                    }
                    return nil
                }
                .sink {
                    self.strings.append($0)
                }
               
                
                    
            }
        }
    }
}

