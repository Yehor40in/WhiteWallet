//
//  LoginAssembler.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import SwiftUI

protocol LoginAssemblerProtocol {
    func loginView(router: any RouterProtocol) -> AnyView
}

extension Container {
    func loginView(router: any RouterProtocol) -> AnyView {
        AnyView(
            LoginView(
                viewModel: 
                    LoginViewModel(
                        w3interactor: createWeb3Coordinator(),
                        router: router
                    )
            )
        )
    }
}

