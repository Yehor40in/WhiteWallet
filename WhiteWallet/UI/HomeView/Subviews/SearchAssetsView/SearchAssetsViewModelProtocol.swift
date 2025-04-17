//
//  SearchAssetsViewModelProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import Foundation

protocol SearchAssetsViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var searchTerm: String { get set }
    var assets: [SearchResultItem] { get set }
}
