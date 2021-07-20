//
//  SliderMenueVM.swift
//  Tennis
//
//  Created by Pranav Suri on 03/02/2021.
//

import Combine
import Firebase
import UIKit

class SliderMenuVM : ObservableObject{
    var imagePath : String {
        if let uid = Auth.auth().currentUser?.uid {
            return "/" + uid + "/1x/profileImage.png"
        }
        return ""
    }
    
    var operation : StorageDownloadTask? = nil
    
    
    func loadImageFromStorage(){
        if DownloadedProfileImage.shared.image == nil {
            print(imagePath)
            operation =  Storage.storage().reference().child(imagePath).getData(maxSize: .max) { (data, error) in
                print("Donwloaded Data")
                print(data)
                data.publisher
                    .compactMap {$0}
                    .map { data in
                        
                        UIImage(data: data)
                    }
                    .assign(to: \.image, on: DownloadedProfileImage.shared)
                
            }
        }
    }
}
