//
//  Container.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import Foundation

class Container: FactoryProtocol {
    static var shared: any FactoryProtocol = Container()
}
