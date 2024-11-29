//
//  AlbumDetailsController.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 29/11/2024.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsController: UIViewController {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var album:Albums?
    let disposeBag = DisposeBag()
    let viewModel = AlbumDetailsVM()
    let filteredList : [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        
        let titleLabel = UILabel()
        titleLabel.text = album?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        
       setupCollectionView()
        setupSearch()
    }
    
    func setupCollectionView(){
        
        viewModel.photoPublishSub.bind(to: collectionView.rx.items(cellIdentifier: "albumDetails", cellType: AlbumDetailsCell.self)) { (index,item,cell) in
            cell.cellSetup(url: item.url )
            
        }.disposed(by: disposeBag)
    }
    
    func setupSearch(){
        search.rx.text.subscribe(onNext:{ [weak self] value in
            guard let self = self else {return}
            self.viewModel.getImages(albumId: self.album?.id ?? 0,searchQuery: value)

            
        }).disposed(by: disposeBag)
    }
    
    
}


extension AlbumDetailsController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}
