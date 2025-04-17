//
//  SearchAssetsView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import SwiftUI

struct SearchAssetsView<ViewModel: SearchAssetsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVStack (pinnedViews: .sectionHeaders) {
                Section (header: headerView()) {
                    ForEach(viewModel.assets) { asset in
                        SearchResultRowView(item: asset)
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
    }
    
    func headerView() -> some View {
        HStack {
            TextField("Start typing", text: $viewModel.searchTerm)
            Image(systemName: "magnifyingglass")
                .padding(.horizontal, 5)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

#Preview {
    SearchAssetsView(
        viewModel: SearchAssetsViewModel()
    )
}
