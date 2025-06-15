//
//  ProfessionalCard
//
//  Created by Ivan Bondaruk on 15/06/2025.
//

import Foundation
import SwiftUI

/// ProfessionalCard ViewModel
///
///
class ProfessionalCardViewViewModel: ObservableObject {
    /// Used to save pressed state
    @State public var isPressed: Bool = false
    /// Used to save hovered state
    @State public var isHovered: Bool = false
    /// Used to save show state for progressBar
    @State public var showProgressBar: Bool = false
    
    /// Card title
    public let title: String
    /// Sub titile
    public let subTitle: String
    /// Icon name
    public let iconName: String
    /// Gradient colors
    public let gradientColors: [Color]
    /// Badge text
    public let badgeText: String?
    /// Action to exec
    public let action: () -> Void
    
    public var iconBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors.map {$0.opacity(0.15)},
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    public var iconGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    public var progressGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    public var badgeGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    // Shadow properties
    public var shadowColor: Color {
        gradientColors.first?.opacity(isPressed ? 0.2 : 0.3) ?? .gray.opacity(0.3)
    }
    
    public var shadowRadius: CGFloat {
        isPressed ? 8 : 12
    }
    
    public var shadowOffset: CGFloat {
        isPressed ? 4 : 8
    }
    
    // Helper Methods
    public func handlePressState(_ pressing: Bool) {
        withAnimation(.easeInOut(duration: 0.1)) {
            isPressed = pressing
        }
    }
    
    public func hapticFeedBack() {
        NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
    }
    
    /// Init
    ///
    /// - Parameters:
    ///   - title: Card title
    ///   - subTitle: Card sub title
    ///   - iconName: Card icon
    ///   - gradientColors: Which colors need to use to make gradient effect
    ///   - badgeText: Card badge text
    ///   - action: Action that needs to be execute when press on card
    public init(title: String, subTitle: String, iconName: String, gradientColors: [Color], badgeText: String?, action: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.gradientColors = gradientColors
        self.badgeText = badgeText
        self.action = action
    }
}
