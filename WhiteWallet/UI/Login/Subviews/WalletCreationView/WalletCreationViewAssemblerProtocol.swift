//
//  WalletCreationViewAssemblerProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import SwiftUI

protocol WalletCreationViewAssemblerProtocol {
    func walletCreationView() -> AnyView
}

extension Container {
    func walletCreationView() -> AnyView {
        AnyView(
            WalletCreationView(
                viewModel: 
                    WalletCreationViewModel(
                        w3coordinator: createWeb3Coordinator()
                    )
            )
        )
    }
}
