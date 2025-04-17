//
//  Router.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 07.07.24.
//

import Foundation

final class Router: RouterProtocol {
    
    static var shared: Router = Router()
    
    @Published var routes: Array<Route> = []
    
    func goBack() { routes.removeLast() }
    func routeToCreateWallet() { routes.append(.createWallet) }
    func routeToImportWallet() { routes.append(.importWallet) }
    func routeToHome() { routes.append(.home) }
    func routeToLogin() { routes.append(.login) }
    func routeToAssetOverview() { routes.append(.assetOverview) }
    func routeToTransaction() { routes.append(.transaction) }
}
