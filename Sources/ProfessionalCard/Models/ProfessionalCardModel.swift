//
//  ProfessionalCardModel.swift
//
//  Created by Ivan Bondaruk on 14/06/2025.
//

import Foundation
import SwiftUI

public struct ProfessionalCardModel: Identifiable, Hashable {
    public let id = UUID()
    public let title: String
    public let subTitle: String
    public let iconName: String
    public let gradientColors: [Color]
    public let badgeText: String?
    
    public init(title: String, subTitle: String, iconName: String, gradientColors: [Color], badgeText: String?) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.gradientColors = gradientColors
        self.badgeText = badgeText
    }
}
