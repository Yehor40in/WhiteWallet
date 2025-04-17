//
//  SearchResultItem.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import Foundation

struct SearchResultItem: Identifiable,  Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var price: String
    var tag: String
    var percentChanged: String
    var imageURL: URL?
}

extension SearchResultItem {
    static var stub: Self {
        .init(
            title: "Lorem ipsum",
            description: "$803.2M Volume",
            price: "$ 1545,10",
            tag: "arrow.up", 
            percentChanged: "0.26",
            imageURL: URL(string: "https://picsum.photos/50/50")
        )
    }
}
