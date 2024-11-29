//
//  AlbumDetailsController.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 29/11/2024.
//

import UIKit

class AlbumDetailsController: UIViewController {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var album:Albums?
    let viewModel = AlbumDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.text = album?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        
        viewModel.getImages(albumId: album?.id ?? 0)
        // Do any additional setup after loading the view.
    }
 
    
}
