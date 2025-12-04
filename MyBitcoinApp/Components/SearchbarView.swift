//
//  SearchbarView.swift
//  MyBitcoinApp
//
//  Created by Durga Peddi on 20/11/25.
//

import SwiftUI

struct SearchbarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.accent)
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15),radius: 10)
        )
        .padding()
    }
}



struct DemoImageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3a/Cat03.jpg"))
            .frame(width: 300, height: 400)
            .scaledToFill()
    }
}


#Preview {
    DemoImageView()
}

