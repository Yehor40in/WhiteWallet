//
//  ImportWalletView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import SwiftUI

/*
 TODO:
    - switch from conditional view disaplying to viewModel state
 */

struct ImportWalletView<ViewModel: ImportWalletViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @FocusState var isFocused: Bool
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            if viewModel.hasActivity {
                ProgressView()
                    .scaleEffect(2)
            } else if viewModel.shouldEnterRecoveryPhrase {
                RecoveryPhraseFormView(
                    phrase: $viewModel.mnemonic,
                    action: viewModel.onImportWallet
                )
            } else {
                content().onAppear { isFocused = true }
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Please enter your password:")
                    .monospaced()
                    .padding()
                TextField("", text: $viewModel.password)
                    .focused($isFocused)
                    .padding(.horizontal)
                Spacer()
                Button {
                    withAnimation {
                        viewModel.shouldEnterRecoveryPhrase = true
                    }
                } label: {
                    Text("Submit")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
                .padding()
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ImportWalletView(
        viewModel:
            ImportWalletViewModel(
                w3coordinator: Web3Coordinator.shared
            )
    )
}
