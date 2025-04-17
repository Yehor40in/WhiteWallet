//
//  WhiteWalletApp.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import SwiftUI

@main
struct WhiteWalletApp: App {
    
    var factory: any FactoryProtocol = Container.shared
    @StateObject var router: Router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.factory, factory)
                .environmentObject(router)
        }
    }
}
