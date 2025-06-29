//
//  HomeScreen.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State private var isPresenting = false

    var sectionRendererRegistry: SectionRendererRegistry = .default()
    var sectionHeaderRendererRegistry = HeaderRendererRegistry.default()

    var body: some View {
        VStack(spacing: 0) {
            HomeHeaderView {
                isPresenting.toggle()
            }
            List {
                ForEach(homeViewModel.sections, id: \.id) { section in
                    sectionHeaderRendererRegistry.view(section: section)
                    sectionRendererRegistry.view(for: section)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
        }
        .onAppear {
            homeViewModel.fetchData()
        }
        .sheet(isPresented: $isPresenting, content: {
            /// Open search view
        })
    }
}
