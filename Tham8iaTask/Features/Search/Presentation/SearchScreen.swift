//
//  SearchScreen.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject var searchViewModel = SearchViewModel()
    var sectionRendererRegistry: SectionRendererRegistry = .default()
    var sectionHeaderRendererRegistry = HeaderRendererRegistry.default()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    SearchBar(
                        text: $searchViewModel.searchText,
                        placeholder: "Search..."
                    )
                    ForEach(searchViewModel.sections, id: \.id) { section in
                        sectionHeaderRendererRegistry.view(section: section)
                        sectionRendererRegistry.view(for: section)
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
            }
        }
        .onAppear {
            searchViewModel.viewAppeared()
        }
        .background(Color("#141520").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SearchScreen()
}
