//
//  SearchAssetsAssembelrProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import SwiftUI

protocol SearchAssetsAssembelrProtocol {
    func searchAssetsView() -> AnyView
}

extension Container {
    func searchAssetsView() -> AnyView {
        AnyView(
            SearchAssetsView(
                viewModel: SearchAssetsViewModel()
            )
        )
    }
}
