//
//  AnySectionItemsRenderer.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//

import SwiftUI

// MARK: - AnySectionItemsRenderer

protocol AnySectionItemsRenderer {
    func render(section: SectionContent) -> AnyView
}
