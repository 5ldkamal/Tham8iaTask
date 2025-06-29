//
//  HomeScreen.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State private var isPresenting = false

    var sectionRendererRegistry: SectionRendererRegistry = .default()
    var sectionHeaderRendererRegistry = HeaderRendererRegistry.default()

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .onAppear {
            homeViewModel.fetchData()
        }
        .refreshable {
            homeViewModel.fetchData()
        }
        .sheet(isPresented: $isPresenting, content: {
            SearchScreen()
        })
    }

    @ViewBuilder
    private var content: some View {
        switch homeViewModel.listState {
        case .idle, .loading:
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundStyle(Color.primaryFont)
        case let .error(message):
            ErrorView(message: message) {
                homeViewModel.fetchData()
            }
        case let .empty(model):
            EmptyStateView(emptyModel: model)
        case let .loaded(items):
            VStack(spacing: 0) {
                HomeHeaderView {
                    isPresenting.toggle()
                }

                List {
                    ForEach(items, id: \.id) { section in
                        sectionHeaderRendererRegistry.view(section: section)
                        sectionRendererRegistry.view(for: section)
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
        }
    }
}
