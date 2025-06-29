//
//  HomeHeaderView.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import Foundation
import SwiftUI

struct HomeHeaderView: View {
    var searchHandler: (() -> Void)?

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "moonphase.waxing.gibbous")
                    .foregroundColor(.yellow)
                Text("Good evening  Khaled ")
                    .foregroundColor(.white)
                    .font(.headline)
            }

            Spacer()

            ZStack(alignment: .topTrailing) {
                Button(action: {
                    searchHandler?()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.primaryFont)
                })
            }
        }
        .padding()
    }
}
