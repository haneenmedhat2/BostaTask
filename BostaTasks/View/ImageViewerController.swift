//
//  ImageViewerController.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 29/11/2024.
//

import UIKit
import Kingfisher

class ImageViewerController: UIViewController,UIScrollViewDelegate {
    var photo : Photos?
     let scrollView = UIScrollView()
     let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
               setupScrollView()
               setupImageView()
    }
    
     func setupScrollView() {
           scrollView.delegate = self
           scrollView.minimumZoomScale = 1.0
           scrollView.maximumZoomScale = 3.0
           scrollView.frame = view.bounds
           view.addSubview(scrollView)
       }

        func setupImageView() {
           guard let photo = photo else { return }
            if let url = photo.url {
                imageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "images"))

            }else{
                imageView.image = UIImage(named: "images")
            }
           imageView.contentMode = .scaleAspectFit
           imageView.frame = scrollView.bounds
           scrollView.addSubview(imageView)
       }

       func viewForZooming(in scrollView: UIScrollView) -> UIView? {
           return imageView
       }
    
    @IBAction func shareBtn(_ sender: UIBarButtonItem) {
        guard let photo = photo, let urlString = photo.url, let url = URL(string: urlString) else {
            print("No image to share")
            return
        }

        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

}
