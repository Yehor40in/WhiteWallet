//
//  RecoveryPhraseView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import SwiftUI

struct RecoveryPhraseView: View {
    
    var phrase: Array<String> = []
    
    @Binding var didSaveRecoveryPhrase: Bool
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Text("Please save your private seed phrase")
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
                                Text("1. " + phrase[0] )
                                    .bold()
                                Text("2. " + phrase[1])
                                    .bold()
                                Text("3. " + phrase[2])
                                    .bold()
                                Text("4. " + phrase[3])
                                    .bold()
                                Text("5. " + phrase[4])
                                    .bold()
                                Text("6. " + phrase[5])
                                    .bold()
                            }
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            Group {
                                Text("7. " + phrase[6])
                                    .bold()
                                Text("8. " + phrase[7])
                                    .bold()
                                Text("9. " + phrase[8])
                                    .bold()
                                Text("10. " + phrase[9])
                                    .bold()
                                Text("11. " + phrase[10])
                                    .bold()
                                Text("12. " + phrase[11])
                                    .bold()
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
                Text("⚠️ For your eyes only")
                    .bold()
                    .font(.title2)
                    .monospaced()
                    .foregroundStyle(.red)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .shadow(color: .orange, radius: 3)
                Spacer()
                Button(action: { didSaveRecoveryPhrase = true }) {
                    Text("I have saved the recovery phrase")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.yellow, .red],
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
    RecoveryPhraseView(phrase: ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve"], didSaveRecoveryPhrase: .constant(false))
}
