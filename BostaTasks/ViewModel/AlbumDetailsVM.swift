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
    var allPhotos : [Photos] = []
    
  //MARK: - Fetch images of specific album

    func getImages(albumId:Int,searchQuery:String?){
        if allPhotos.isEmpty{
        provider.request(.getPhotos(albumId: albumId)){ [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do{
                    self.allPhotos = try JSONDecoder().decode([Photos].self, from: response.data)
                    self.filterByTitle(searchQuery: searchQuery)

                    
                }catch(let error){
                    print("Error in decoding photos\(error)")
                }
            case .failure(let error):
                print("Photos Request Failed,\(error)")
            }
            
        }
        } else{
            filterByTitle(searchQuery: searchQuery)
        }
  }
    
    //MARK: - Filter images using the title
    
    func filterByTitle(searchQuery:String?){
        var filteredPhotos :[Photos] = []
        if searchQuery?.isEmpty == false {
             filteredPhotos = allPhotos.filter{ $0.title?.lowercased().starts(with: searchQuery!.lowercased()) ?? false }
        } else{
            filteredPhotos = allPhotos
        }
        photoPublishSub.onNext(filteredPhotos)
    }
}
