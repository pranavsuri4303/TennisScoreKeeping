//
//  SearchPlayerVM.swift
//  Tennis
//
//  Created by Pranav Suri on 03/02/2021.
//


import Combine
import Firebase
import UIKit

var downloadingImagesOperations : [StorageDownloadTask?] = []
class SearchPlayerVM : ObservableObject{
    let player : PlayerModel
    @Published var downloadedImage : UIImage? = nil
    var operation : StorageDownloadTask? = nil
    
    init(player : PlayerModel){
        self.player = player
        loadImageFromStorage()
    }
    
    func loadImageFromStorage(){
        if downloadedImage == nil  {
            
            let imagePath = player.uid + "/1x/profileImage.png"
            
            operation =  Storage.storage().reference().child(imagePath).getData(maxSize: .max) { (data, error) in
                
                data.publisher
                    .compactMap {$0}
                    .map { data in
                        UIImage(data: data)
                    }
                    .assign(to: \.downloadedImage, on: self)
                
            }
            
            downloadingImagesOperations.append(operation)
        }
        
    }
    
    func loadImageFromStorageWithBiggerSize(){

        let imagePath = player.uid + "/2x/profileImage.png"
        print(imagePath)
        operation =  Storage.storage().reference().child(imagePath).getData(maxSize: .max) { (data, error) in
            
            data.publisher
                .compactMap {$0}
                .map { data in
                    UIImage(data: data)
                }
                .assign(to: \.downloadedImage, on: self)
            
        }
        
        downloadingImagesOperations.append(operation)
    }
    
    
    
    
    
    
}
