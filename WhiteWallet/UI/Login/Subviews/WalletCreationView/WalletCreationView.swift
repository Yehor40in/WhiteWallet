//
//  CreateHDWalletView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 16.07.24.
//

import SwiftUI

/*
 TODO
    - adjust focus field logic
    - switch from conditional view disaplying to viewModel state
 */

struct WalletCreationView<ViewModel: WalletCreationViewModelProtocol>: View {
    
    enum FocusedField {
        case password
        case verifyPassword
    }
    
    @ObservedObject var viewModel: ViewModel
    @FocusState var focusedField: FocusedField?
    
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
            } else if viewModel.shouldDisplayRecoveryPhrase {
                if viewModel.isRecoveryPhraseSaved {
                    Text("Recovery phrase saveed! Now verify view goes here.")
                        .foregroundStyle(.white)
                } else {
                    RecoveryPhraseView(
                        phrase: viewModel.expectedMnemonics,
                        didSaveRecoveryPhrase: $viewModel.isRecoveryPhraseSaved
                    )
                }
            } else {
                content().onAppear { focusedField = .password }
            }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        VStack(alignment: .leading) {
            Group {
                Text("Setup a password to secure your wallet")
                    .fontDesign(.monospaced)
                SecureField("", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
            }
            .padding(.bottom, 10)
            if viewModel.shoudVerifyPassword {
                Group {
                    Text("Verify your password")
                        .fontDesign(.monospaced)
                    SecureField("...", text: $viewModel.passwordToVerify)
                        .focused($focusedField, equals: .verifyPassword)
                }
            }
            Spacer()
            if !viewModel.shoudVerifyPassword {
                Button(action: viewModel.goToVerifyPassword, label: {
                    Text("Next")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.red, .yellow],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                })
                .transition(.opacity)
            } else {
                Button(action: viewModel.onPasswordVerify, label: {
                    Text("Done")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.purple, .red],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                })
                .transition(.opacity)
            }
        }
        .padding()
        .foregroundStyle(.white)
    }
}

#Preview {
    WalletCreationView(
        viewModel:
            WalletCreationViewModel(
                w3coordinator: Web3Coordinator.shared
            )
    )
}
