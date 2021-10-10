//
//  ImageListCell.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit

class ImageListCell: UITableViewCell {

    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI(){
        setupContainerView()
    }
    
    private func setupContainerView(){
        containerView.layer.cornerRadius = 6
    }
    
    
    func setupCell(info: ImageListCellUIProtocol, indexPath: IndexPath){
        authorLabel.text = "\("ImageList_By".localized): \(info.authorName ?? "")"
        imageViewer.loadImageUsingCache(withUrl: info.imageUrl ?? "", cellIndexPathRow: indexPath.row, placeHolderImage: nil)
    }
    
}
