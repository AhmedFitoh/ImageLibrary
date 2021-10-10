//
//  Alertable.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit


protocol Alertable {
    func showAlert(title: String?, message: String?, completionHandler: (()->())?)
    func showAlertWithCancel(title: String?, message: String?, completionHandler: (()->())?, cancelHandler: (()->())?)

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
    
    func showAlertWithCancel(title: String?, message: String?, completionHandler: (()->())?, cancelHandler: (()->())?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Common_Ok".localized, style: .default) { _ in
            completionHandler?()
        }
        
        let cancelAction = UIAlertAction(title: "Common_Cancel".localized, style: .cancel) { _ in
            cancelHandler?()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}
