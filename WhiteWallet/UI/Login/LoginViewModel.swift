//
//  LoginViewModel.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import Foundation
import web3swift
import Web3Core
import Combine

/*
 TODO
  - Implement WalletLocalRepository.notifyWalletCreated + PasstrhroughSubject + subscription
 */

final class LoginViewModel: LoginViewModelProtocol {
    
    private let w3coordinator: Web3CoordinatorProtocol
    private var cancellables: [AnyCancellable] = []
    private let router: any RouterProtocol
    
    @Published var hasActivity: Bool = false
    @Published var password: String = ""
    @Published var mnemonic: [String] = []
    @Published var showsWalletSetupSheet: Bool = false
    @Published var shouldShowErrorMessage: Bool = false
    @Published var shouldTryFetchingWallet: Bool = true
    
    var actionType: LoginViewModelActionType?
    
    init(
        w3interactor: Web3CoordinatorProtocol,
        router: any RouterProtocol
    ) {
        self.w3coordinator = w3interactor
        self.router = router
        setupSubscriptions()
    }
    
    func setupSubscriptions() -> Void {
        /*
            TODO:
            -  fix instatn transition to home view
                (need to let user save recovery phrase first -> then redirect)
         */
        w3coordinator
            .walletEventPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
               self?.handleResult()
            })
            .store(in: &cancellables)
        
        w3coordinator
            .walletErrortPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
               self?.handleError()
            })
            .store(in: &cancellables)
    }
    
    func onInitExisitngWallet() -> Void {
        hasActivity = true
        w3coordinator.initializeExistingWallet()
    }
    
    func showSheet(_ state: LoginViewModelActionType) -> Void {
        self.actionType = state
        showsWalletSetupSheet = true
    }
    
    private func handleResult() -> Void {
        hasActivity = false
        /*
         the cause of the infinite avigation bug here
         */
        router.routeToHome()
    }
    
    private func handleError() -> Void {
        hasActivity = false
        shouldTryFetchingWallet = false
    }
}
