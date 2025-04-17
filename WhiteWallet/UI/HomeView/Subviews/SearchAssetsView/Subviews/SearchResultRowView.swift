//
//  SearchResultRowView.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 20.07.24.
//

import SwiftUI

struct SearchResultRowView: View {
    
    let item: SearchResultItem
    
    init(item: SearchResultItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    if let imageURL = item.imageURL {
                        AsyncImage(
                            url: imageURL,
                            content: { image in
                                image
                                    .resizable()
                            },
                            placeholder: {
                                Color.gray
                            }
                        )
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 10)
                    }
                    VStack(alignment: .leading){
                        VStack (alignment: .leading) {
                            Text(item.title)
                                .monospaced()
                                .fontWeight(.heavy)
                            Text(item.description)
                                .monospaced()
                                .bold()
                        }
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.price)
                        .fontWeight(.heavy)
                    HStack {
                        Text("\(item.percentChanged) %")
                        Image(systemName: item.tag)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

#Preview {
    SearchResultRowView(item: .stub)
}
