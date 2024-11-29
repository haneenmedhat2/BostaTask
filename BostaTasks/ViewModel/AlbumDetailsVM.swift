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
    let photoPublishSub : PublishSubject<[Photos]> = PublishSubject()
    
    func getImages(albumId:Int){
        provider.request(.getPhotos(albumId: albumId)){ [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do{
                    let photos = try JSONDecoder().decode([Photos].self, from: response.data)
                    self.photoPublishSub.onNext(photos)
                    
                }catch(let error){
                    print("Error in decoding photos\(error)")
                }
            case .failure(let error):
                print("Photos Request Failed,\(error)")
            }
            
        }
    }
    
    
}
