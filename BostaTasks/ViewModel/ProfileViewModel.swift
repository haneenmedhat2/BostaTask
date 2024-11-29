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
                print("User request failed \(error)")
                
            }
        }
        
    }
        
}


