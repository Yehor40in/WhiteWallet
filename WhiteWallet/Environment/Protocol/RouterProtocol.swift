//
//  RouterProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 07.07.24.
//

import Foundation

protocol RouterProtocol: ObservableObject {
    var routes: Array<Route> { get set }
    
    func goBack() -> Void
    func routeToCreateWallet() -> Void
    func routeToImportWallet() -> Void
    func routeToHome() -> Void
    func routeToLogin() -> Void
    func routeToAssetOverview() -> Void
    func routeToTransaction() -> Void
}
