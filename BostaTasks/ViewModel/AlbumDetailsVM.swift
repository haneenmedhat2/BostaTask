//
//  AlbumDetailsVM.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 29/11/2024.
//

import Foundation
import Moya
import RxSwift

class AlbumDetailsVM{
    
    let provider = MoyaProvider<NetwrokService>()
    
    func getImages(albumId:Int){
        provider.request(.getPhotos(albumId: albumId)){ result in
            switch result {
            case .success(let response):
                do{
                    let photos = try JSONDecoder().decode([Photos].self, from: response.data)
                    print(photos)
                    
                }catch(let error){
                    print("Error in decoding photos\(error)")
                }
            case .failure(let error):
                print("Photos Request Failed,\(error)")
            }
            
        }
    }
    
    
}
