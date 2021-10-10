//
//  ImageViewerView.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import UIKit

class ImageViewerView: UIViewController, Alertable {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - VIPER Stack
    var presenter: ImageViewerViewToPresenterProtocol!
    
    // MARK: - Instance Variables
    let saveImageButton = UIBarButtonItem(systemItem: .save)
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidFinishLoading()
    }
    
    private func setupUI(){
        setupScrollView()
        setupSaveImageButton()
    }
    
    private func setupScrollView(){
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 3.0
        scrollView.delegate = self
    }
    
    private func setupSaveImageButton(){
        saveImageButton.isEnabled = false
        saveImageButton.target = self
        saveImageButton.action = #selector(saveImageAction)
        self.navigationItem.rightBarButtonItem = saveImageButton
    }
    
    @objc private func saveImageAction(){
        guard let image = imageView.image else {
            return
        }
        let manager = SaveToPhotosManager()
        manager.addToPhoto(toCameraRoll: presenter.imageItem.id ?? "Unknown",
                           withAlbumName: "Image Library",
                           with: image) { [weak self] success, error in
            if success {
                self?.showAlert(title: nil,
                                message: "ImageViewerView_ImageSavedMessage".localized,
                                completionHandler: nil)
            } else {
                self?.showAlert(title: nil,
                                message: error?.localizedDescription ?? "",
                                completionHandler: nil)
            }
        }
    }
    
}

// MARK: - Presenter to View Protocol
extension ImageViewerView: ImageViewerPresenterToViewProtocol {
    func loadImage(_ info: ImageListElement) {
        scrollView.contentSize = CGSize(width: info.width ?? 0, height: info.height ?? 0)
        imageView.loadImageUsingCache(withUrl: info.downloadURL ?? "") { [weak self] in
            self?.view.backgroundColor = self?.imageView.image?.averageColor
            self?.saveImageButton.isEnabled = true
        }
    }
}


// MARK: - UIScrollViewDelegate
extension ImageViewerView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
