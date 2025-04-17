 //
 //  HomeView.swift
 //  WhiteWallet
 //
 //  Created by Yehor Sorochin on 20.07.24.
 //

 import SwiftUI

 /*
  TODO
     - add opacitiy based transition
     - pass overlay Binding to searchAssetsView
     - Implement ViewModel
  */

 struct HomeView<ViewModel: HomeViewModelProtocol>: View {
     
     @Environment(\.factory) var factory: FactoryProtocol
     @ObservedObject var viewModel: ViewModel
     @State private var scrollPosition: Int?
     @State var showsOverlay: Bool = false
     
     var body: some View {
         ScrollView {
             LazyVStack {
                 Color.clear
                     .frame(height: 100)
                     .id(1)
                 VStack{
                     Text("Home View")
                 }
                 .frame(maxWidth: .infinity)
                 .frame(height: 1200)
                 .id(2)
             }
             .scrollTargetLayout()
             .background {
                 GeometryReader { proxy in
                     Color.clear
                         .preference(
                             key: ViewOffsetKey.self,
                             value: proxy.frame(in: .named("HomeView+ScrollView")).origin.y
                         )
                 }
             }
             .overlay {
                 if showsOverlay {
                     factory.searchAssetsView()
                 }
             }
             .onPreferenceChange(ViewOffsetKey.self) { value in
                 withAnimation {
                     showsOverlay = value > -100
                 }
             }
         }
         .coordinateSpace(name: "HomeView+ScrollView")
         .scrollPosition(id: $scrollPosition)
         .onAppear {
             scrollPosition = 2
         }
     }
 }

 #Preview {
     HomeView(viewModel: HomeViewModel())
 }
