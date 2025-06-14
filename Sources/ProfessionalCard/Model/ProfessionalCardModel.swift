//
//  ProfessionalCardModel.swift
//  WeC
//
//  Created by Ivan Bondaruk on 14/06/2025.
//

import Foundation
import SwiftUI

struct ProfessionalCardModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let gradienColors: [Color]
    let badgeText: String?
    
    init(title: String, subtitle: String, iconName: String, gradienColors: [Color], badgeText: String?) {
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.gradienColors = gradienColors
        self.badgeText = badgeText
    }
}
