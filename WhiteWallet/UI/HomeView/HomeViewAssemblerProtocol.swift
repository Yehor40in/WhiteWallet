//
//  HomeViewAssemblerProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import SwiftUI

protocol HomeViewAssemblerProtocol {
    func homeView() -> AnyView
}

extension Container {
    func homeView() -> AnyView {
        AnyView(
            HomeView(viewModel: HomeViewModel())
        )
    }
}
