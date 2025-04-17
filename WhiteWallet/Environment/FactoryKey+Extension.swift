//
//  FactoryKey.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import Foundation
import SwiftUI

private struct FactoryKey: EnvironmentKey {
    static let defaultValue = Container.shared
}

extension EnvironmentValues {
    var factory: any FactoryProtocol {
        get { self[FactoryKey.self] }
        set { self[FactoryKey.self] = newValue as! Container }
    }
}
