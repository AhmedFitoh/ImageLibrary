//
//  Alertable.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit


protocol Alertable {
    func showAlert(title: String?, message: String?, completionHandler: (()->())?)

}

extension Alertable where Self: UIViewController {
    func showAlert(title: String?, message: String?, completionHandler: (()->())?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Common_Ok".localized, style: .default) { _ in
            completionHandler?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
