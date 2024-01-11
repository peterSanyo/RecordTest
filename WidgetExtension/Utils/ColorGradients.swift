//
//  ColorGradients.swift
//  RecordTest
//
//  Created by Péter Sanyó on 11.01.24.
//

import SwiftUI

struct CustomGradient {
    static let customGradient = LinearGradient(
        gradient: Gradient(
            stops: [
                .init(color: .clear, location: 0.2),
                .init(color: .white.opacity(0.3), location: 0.7),
                .init(color: .black, location: 1),
            ]
        ),
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
}
