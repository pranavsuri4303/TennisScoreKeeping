//
//  SliderMenueVM.swift
//  Tennis
//
//  Created by Hossam on 03/02/2021.
//

import Combine
import Firebase
import UIKit

class SliderMenueVM : ObservableObject{
    var imagePath : String {
        if let uid = Auth.auth().currentUser?.uid {
            return uid + "/profileImage.jpeg"
        }
        return ""
    }
    
    var operation : StorageDownloadTask? = nil
   
    
    func loadImageFromStorage(){
        
        
        if DownloadedProfileImage.shared.image == nil {
            operation =  Storage.storage().reference().child(imagePath).getData(maxSize: .max) { (data, error) in
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
