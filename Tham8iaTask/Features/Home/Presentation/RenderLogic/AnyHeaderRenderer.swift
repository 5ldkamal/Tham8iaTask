//
//  AnyHeaderRenderer.swift
//  Tham8iaTask
//
//  Created by Khaled Kamal on 29/06/2025.
//
import SwiftUI

// MARK: - AnySectionItemsRenderer

protocol AnyHeaderRenderer {
    func render(header: SectionContent) -> AnyView?
}
