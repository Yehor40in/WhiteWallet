//
//  ImportWalletViewAssemblerProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import SwiftUI

protocol ImportWalletViewAssemblerProtocol {
    func importWalletView() -> AnyView
}

extension Container {
    func importWalletView() -> AnyView {
        AnyView(
            ImportWalletView(
                viewModel: 
                    ImportWalletViewModel(
                        w3coordinator: createWeb3Coordinator()
                    )
            )
        )
    }
}
