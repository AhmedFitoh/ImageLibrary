//
//  String+localized.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
