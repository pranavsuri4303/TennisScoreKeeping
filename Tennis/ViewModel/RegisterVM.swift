//
//  RegisterViewModel.swift
//  Tennis
//
//  Created by Sameer Suri on 21/1/21.
//

import SwiftUI
import LocalAuthentication
import Firebase

class RegisterVM : ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var yob = ""
    @Published var nationality: String?
    @Published var gender = "Male"
    var imageData : Data?
    // User Data....
    
    @AppStorage("status") var logged = false
    
    // For Alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    // Loading Screen...
    @Published var isLoading = false
    
    // Getting BioMetricType....
    
    
    // Create User...
    func createUser() {
        print(#function)
        isLoading = true
        
        
        Auth.auth().createUser(withEmail: email, password: password) {(res,errora) in
            if let err = errora{
                self.alert.toggle()
                self.alertMsg = err.localizedDescription
                self.isLoading = false

            }else{
                if let userID = res?.user.uid {
                    self.uploadImageToDatabase(userID: userID) { (result) in
                        switch result {
                        
                        case .success(let path):
                            let change = res?.user.createProfileChangeRequest()
                            change?.displayName = self.name
                            change?.commitChanges(){ erro in
                                if let error = erro{
                                    self.alertMsg = error.localizedDescription
                                    self.alert.toggle()
                                    return
                                }
                            }
                            let db = Firestore.firestore()
                            let uidStr = (res?.user.uid)!
                            var docData: [String: Any] = [
                                "name": "\(self.name)",
                                "email": "\(self.email)",
                                "uid": "\(String(describing: uidStr))",
                                "yob": "\(self.yob)",
                                "nationality": "\(self.nationality)",
                                "gender": "\(self.gender)" ,
                            ]
                            if let path = path {
                                docData.updateValue(path, forKey: "imageProfilePath")
                            }
                            db.collection("users").document(uidStr).setData(docData) { err in
                                print("uploading data")
                                if let err = err {
                                    self.alertMsg = err.localizedDescription
                                    self.alert.toggle()
                                    return
                                    
                                } else {
                                    print("Finished Without Error")
                                    withAnimation{
                                        self.logged.toggle()
                                        self.isLoading = false
                                    }
                                }
                            }
                        case .failure(let error):
                            self.alertMsg = error.localizedDescription
                            self.alert.toggle()
                        }
                    }
                }
            }
            
        }
    }
    
    func configProfileImageDataFrom(UIImage image : UIImage?){
        if let image = image , let data = image.jpegData(compressionQuality: 0.005){
            self.imageData = data
        }
    }
    
    func uploadImageToDatabase( userID : String, completion : @escaping (Result<String?, Error>)->Void){
        
        struct FaildToUploadImage : Error {}
        if let data = imageData {
            Firebase.Storage.storage().reference().child(userID).child("profileImage.png").putData(data, metadata: nil) { (metaData, error) in
                if let error = error {
                    completion(Result.failure(error))
                    return
                }
                if let metaData = metaData , let path = metaData.path {
                    completion(Result.success(path))
                    return
                }
                
            }
            
        }
        else{
            completion(Result.success(nil))
        }
    }
}
