//
//  ImageListView.swift
//
//  Created by AhmedFitoh on 10/10/21.
//  
//

import UIKit

class ImageListView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imagesTableView: UITableView!
    
    // MARK: - VIPER Stack
    var presenter: ImageListViewToPresenterProtocol!
    
    // MARK:- Instance Variable

    let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidFinishLoading()
    }
    
    private func setupUI(){
        setupImageTableView()
        setupActivityIndicator()
    }
    
    private func setupImageTableView(){
        imagesTableView.tableFooterView = UIView()
        
        imagesTableView.register(UINib(nibName: "\(ImageListCell.self)", bundle: nil), forCellReuseIdentifier: "\(ImageListCell.self)")
        imagesTableView.register(UINib(nibName: "\(AdCell.self)", bundle: nil), forCellReuseIdentifier: "\(AdCell.self)")
    }
    
    private func setupActivityIndicator(){
        activityIndicator.hidesWhenStopped = true
        let refreshBarButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = refreshBarButton
    }
    
}

// MARK: - Presenter to View Protocol
extension ImageListView: ImageListPresenterToViewProtocol {
   
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func addCellWith(indices: Range<Int>) {
        let newIndices = indices.map {IndexPath(row: $0, section: 0)}
        imagesTableView.insertRows(at: newIndices, with: .fade)
    }
    
}


// MARK: - TableView Delegates
extension ImageListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = presenter?.list [indexPath.row]
        switch cellType {
        case .adCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(AdCell.self)", for: indexPath) as? AdCell
            
            return cell ?? UITableViewCell()
        case .imageCell(let imageItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageListCell.self)", for: indexPath) as? ImageListCell
            cell?.setupCell(info: imageItem, indexPath: indexPath)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = presenter?.list [indexPath.row]
        switch cellType {
        case .adCell:
            return 44
        case .imageCell:
            return 200
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayCellAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.userDidSelectItem(at: indexPath.row)
    }
}
