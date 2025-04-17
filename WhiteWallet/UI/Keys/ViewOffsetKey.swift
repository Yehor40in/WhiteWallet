//
//  ViewOffsetKey.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
