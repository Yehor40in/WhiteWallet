//
//  FactoryProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation

typealias FactoryProtocol = LoginAssemblerProtocol &
                            SearchAssetsAssembelrProtocol &
                            HomeViewAssemblerProtocol &
                            WalletCreationViewAssemblerProtocol &
                            ImportWalletViewAssemblerProtocol
