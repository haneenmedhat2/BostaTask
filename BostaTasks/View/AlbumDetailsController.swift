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
        
        //collectionview layout
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        //UI title
        let titleLabel = UILabel()
        titleLabel.text = album?.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupSearch()
        setupCellSelection()
    }
    
    //MARK: - Collectionview setup
    
    func setupCollectionView(){
        viewModel.photoPublishSub
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "albumDetails", cellType: AlbumDetailsCell.self)) { (index,item,cell) in
            cell.cellSetup(url: item.url )
            
        }.disposed(by: disposeBag)
    }
 
    //MARK: - Search setup
    
    func setupSearch(){
        search.rx.text
            .subscribe(onNext:{ [weak self] value in
            guard let self = self else {return}
            self.viewModel.getImages(albumId: self.album?.id ?? 0,searchQuery: value)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Cell selection setup

    func setupCellSelection(){
        collectionView.rx.modelSelected(Photos.self)
            .subscribe(onNext: { [weak self] selectedItem in
                guard let self = self else {return}
                let viewerController = self.storyboard?.instantiateViewController(withIdentifier: "imageViewer") as! ImageViewerController
                viewerController.photo = selectedItem
                self.navigationController?.pushViewController(viewerController, animated: true)
            }).disposed(by: disposeBag)
    }
}

//MARK: - Collectionview layout

extension AlbumDetailsController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}
