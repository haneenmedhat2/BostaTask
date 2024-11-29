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
            
            self.getUserAlbum(userId: user?.id ?? 0)
            }.disposed(by: disposeBag)
      }
    
    func getUserAlbum(userId:Int){
        profileViewModel.getAlbums(let: userId)
        profileViewModel.userAlbumsPub.bind(to: tableView.rx.items(cellIdentifier: "albums", cellType: AlbumsCell.self)) { (index,item,cell) in
            
            cell.setupCell(title: item.title ?? "No title found")
        }.disposed(by: disposeBag)
            
        
    }


}

extension ProfileController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let label = UILabel(frame: CGRect(x: 16, y: -15, width: tableView.frame.width - 32, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "My Albums"
        header.addSubview(label)
        return header
    }
}

