//
//  Style.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation
import SwiftUI


final class Style {
    
    public enum Appearance {
        case light
        case dark
    }
    
    public static func primaryColorScheme() -> Style.Appearance {.light}
    
    public static func titleFont() -> Font {Font.largeTitle.lowercaseSmallCaps()}
    public static func footnoteFont() -> Font {Font.system(.subheadline, design: .serif, weight: .bold)}
    //
    // @dev: Constants
    //
    public static func ten_cgf() -> CGFloat {10}
    public static func zero_cgf() -> CGFloat {0}
    public static func fifty_cgf() -> CGFloat {50}
    public static func thirty_cgf() -> CGFloat {30}
    public static func twenty_cgf() -> CGFloat {20}
    public static func three60_cgf() -> CGFloat {360}
    //
    // @dev: Default gradient parameters
    //
    public static func defaultStartRadius() -> CGFloat {Style.zero_cgf()}
    public static func defaultEndRadius() -> CGFloat {Style.three60_cgf()}
    
    public static func primaryLinearGradientFilling() -> LinearGradient {
        LinearGradient(
            colors: [
                Color.cyan,
                Color.purple
            ],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
    public static func primaryRadialGradientFilling() -> RadialGradient {
        RadialGradient(
            colors: [
                Color.purple,
                Color.white
            ],
            center: .center,
            startRadius: defaultStartRadius(),
            endRadius: defaultEndRadius()
        )
    }
    
    public static func primaryLinearGradientFillingVariantDark() -> LinearGradient {
        LinearGradient(
            colors: [
                Color.white,
                Color.gray
            ],
            startPoint: .center,
            endPoint: .topTrailing
        )
    }
    
    public static func primaryLinearGradientFillingVariantDark_1() -> LinearGradient {
        LinearGradient(
            colors: [
                Color.gray,
                Color.black
            ],
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
    //
    // @dev: Default stack spacing
    //
    public static func defaultStackSpacing() -> CGFloat {20};
}



