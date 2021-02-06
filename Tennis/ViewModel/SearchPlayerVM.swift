//
//  SearchPlayerVM.swift
//  Tennis
//
//  Created by Hossam on 03/02/2021.
//


import Combine
import Firebase
import UIKit

var downloadingImagesOperations : [StorageDownloadTask?] = []
class SearchPlayerVM : ObservableObject{
    let player : PlayerModel
    @Published var downloadedImage : UIImage? = nil{
        didSet{
            print("SENTNTNT")
        }
    }
    var operation : StorageDownloadTask? = nil
    init(player : PlayerModel){
        self.player = player
        loadImageFromStorage()
    }
    func loadImageFromStorage(){
        if downloadedImage == nil  {
            
            operation =  Storage.storage().reference().child(player.imagePath).getData(maxSize: .max) { (data, error) in
                print(data)
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
}
