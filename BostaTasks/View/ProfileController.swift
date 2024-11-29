//
//  ViewController.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 28/11/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let profileViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUserData()
    }
    
    func viewUserData(){
        
        profileViewModel.getUser()
        profileViewModel.userPubSub.subscribe{[weak self] value in
            guard let self = self else {return}
            let user = value.element
            let name = user?.name ?? "Name not available"
            let address = user?.address
            let fullAddress = "\(address?.street ?? "Street not available"), \(address?.suite ?? "Suite not available"), \(address?.city ?? "City not available"), \(address?.zipcode ?? "Zipcode not available")"
                        
            self.nameLabel.text = name
            self.addressLabel.text = fullAddress
            
            }.disposed(by: disposeBag)
    }


}


