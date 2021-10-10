//
//  Bundle+UnitTestBundle.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

extension Bundle {
    private class Test {}
    public class var unitTestBundle: Bundle {
        return Bundle(for: Test.self)
    }
}
