//
//  RecoveryPhraseFormView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 26.07.24.
//

import SwiftUI

struct RecoveryPhraseFormView: View {
    
    @Binding var phrase: Array<String>
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Text("Please enter your seed phrase")
                    .bold()
                    .font(.title3)
                    .monospaced()
                    .foregroundStyle(.white)
                    .padding()
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack (spacing: 20) {
                    if (phrase.count > 0) {
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                HStack {
                                    Text("1.")
                                        .bold()
                                    TextField("", text: $phrase[0])
                                }
                                HStack {
                                    Text("2.")
                                        .bold()
                                    TextField("", text: $phrase[1])
                                }
                                HStack {
                                    Text("3.")
                                        .bold()
                                    TextField("", text: $phrase[2])
                                }
                                HStack {
                                    Text("4.")
                                        .bold()
                                    TextField("", text: $phrase[3])
                                }
                                HStack {
                                    Text("5.")
                                        .bold()
                                    TextField("", text: $phrase[4])
                                }
                                HStack {
                                    Text("6.")
                                        .bold()
                                    TextField("", text: $phrase[5])
                                }
                                
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                HStack {
                                    Text("7.")
                                        .bold()
                                    TextField("", text: $phrase[6])
                                }
                                HStack {
                                    Text("8.")
                                        .bold()
                                    TextField("", text: $phrase[7])
                                }
                                HStack {
                                    Text("9.")
                                        .bold()
                                    TextField("", text: $phrase[8])
                                }
                                HStack {
                                    Text("10.")
                                        .bold()
                                    TextField("", text: $phrase[9])
                                }
                                HStack {
                                    Text("11.")
                                        .bold()
                                    TextField("", text: $phrase[10])
                                }
                                HStack {
                                    Text("12.")
                                        .bold()
                                    TextField("", text: $phrase[11])
                                }
                                
                            }
                        }
                    }
                }
                .monospaced()
                .foregroundStyle(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 1)
                )
                .padding()
                Spacer()
                Button(action: action) {
                    Text("Submit")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RecoveryPhraseFormView(phrase: .constant(["", "", "", "","", "", "", "","", "", "", ""]), action: {})
}

