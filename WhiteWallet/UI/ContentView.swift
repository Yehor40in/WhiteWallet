//
//  ContentView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.factory) var factory: FactoryProtocol
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            factory.loginView(router: router)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        factory.homeView()
                    default:
                        Text("Deffault destination")
                    }
                    
                }
        }
    }
}

#if DEBUG
#Preview {
    ContentView()
        .environment(\.factory, Container())
        .environmentObject(Router.shared)
}
#endif
