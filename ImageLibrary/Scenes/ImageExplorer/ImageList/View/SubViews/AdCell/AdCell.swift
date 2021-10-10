//
//  AdCell.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit

class AdCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var adDescLabel: UILabel!
    
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
}
