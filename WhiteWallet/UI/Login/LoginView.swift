//
//  LoginView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import SwiftUI

/*
 TODO:
    - switch from conditional view disaplying to viewModel state
 */

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.factory) var factory: FactoryProtocol
    @EnvironmentObject var router: Router
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.hasActivity {
            ProgressView()
                .scaleEffect(2)
        } else {
            content()
                .onAppear {
                    if viewModel.shouldTryFetchingWallet {
                        viewModel.onInitExisitngWallet()
                    }
                }
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            Text("Welcome.")
                .font(.title)
                .fontDesign(.monospaced)
                .foregroundStyle(.black)
                .bold()
            VStack {
                Spacer()
                Button(action: { viewModel.showSheet(.creatingWallet) }, label: {
                    Text("Create wallet")
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
                Button(action: { viewModel.showSheet(.importingWallet) }, label: {
                    Text("I already have a wallet")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.black, .red],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                })
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.showsWalletSetupSheet) {
            switch viewModel.actionType {
            case .creatingWallet:
                factory.walletCreationView()
            case .importingWallet:
                factory.importWalletView()
            case .none:
                Text("Hello World!")
            }
        }
    }
}

#if DEBUG
#Preview {
    LoginView(viewModel: 
                LoginViewModel(
                    w3interactor: Web3Coordinator.shared,
                    router: Router()
                )
    )
    .environmentObject(Router.shared)
}
#endif
