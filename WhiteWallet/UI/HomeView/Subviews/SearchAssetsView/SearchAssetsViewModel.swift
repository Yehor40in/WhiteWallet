//
//  SearchAssetsViewModel.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import Foundation

final class SearchAssetsViewModel: SearchAssetsViewModelProtocol {
    @Published var isLoading: Bool = false
    @Published var searchTerm: String = ""
    /*
     Testing purpose - to be changed in the future updates
     */
    @Published var assets: [SearchResultItem] = [
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub,
        .stub
    ]
}
