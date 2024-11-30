//
//  ProfileViewModel.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 28/11/2024.
//

import Foundation
import Moya
import RxSwift

class ProfileViewModel{
    
    let provider = MoyaProvider<NetwrokService>()
    let userPubSub : PublishSubject<User> = PublishSubject()
    let userAlbumsPub : PublishSubject<[Albums]> = PublishSubject()

    
//MARK: - Fetch user's data
    
    func getUser() {
        provider.request(.getUser){[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do{
                    let users = try JSONDecoder().decode([User].self,from: response.data)
                    
                    guard let randomUser = users.randomElement() else
                    {   print("No user found")
                        return
                    }
                    self.userPubSub.onNext(randomUser)
                
                }catch(let error){
                    print("Error in decoding user's data \(error)")
                }
                
            case .failure(let error):
                print("User Request Failed, \(error)")
                
            }
        }
        
    }
    
    //MARK: - Fetch user's albums

    func getAlbums(userId : Int){
      provider.request(.getUserAlbums(userId: userId)){ [weak self] result in
          guard let self = self else {return}
            switch result {
            case .success(let response):
                do{
                    let albums = try JSONDecoder().decode([Albums].self, from: response.data)
                    self.userAlbumsPub.onNext(albums)
                    
                }catch(let error){
                   print("Error decoding album's data \(error)")
                }
                
            case .failure(let error):
                print("User Albums Request Faild, \(error)")
            }
        }
    }
        
}


