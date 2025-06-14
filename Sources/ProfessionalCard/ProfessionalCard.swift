//
//  ProfessinalCard.swift
//  WeC
//
//  Created by Ivan Bondaruk on 14/06/2025.
//

import SwiftUI
import AppKit

public struct ProfessionalCardView: View {
    let title: String
    let subTitle: String
    let iconName: String
    let gradientColors: [Color]
    let badgeText: String?
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    @State private var isHovered: Bool = false
    @State private var showProgressBar: Bool = false
    
    public init(title: String, subTitle: String, iconName: String, gradientColors: [Color], badgeText: String?, action: @escaping () -> Void, isPressed: Bool = false, isHovered: Bool = false, showProgressBar: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.gradientColors = gradientColors
        self.badgeText = badgeText
        self.action = action
        self.isPressed = isPressed
        self.isHovered = isHovered
        self.showProgressBar = showProgressBar
    }
    
    public var body: some View {
        Button {
            
        } label: {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6,), value: isPressed)
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity,
            pressing: handlePressState,
            perform: {}
        )
        .onHover{ hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                showProgressBar = true
            }
        }
    }
    
    // Card Content
    private var cardContent: some View {
        VStack(spacing: 20) {
            headerSection
            
            if showProgressBar {
                progressIndicator
            }
            
            if let badge = badgeText {
                badgeSection(badge)
            }
        }
        .padding(24)
        .background(cardBackground)
        .overlay(cardBorder)
    }
    
    // Header Section
    private var headerSection: some View {
        HStack(spacing: 16) {
            iconContainer
            
            Spacer()
            
            textContent
        }
    }
    
    // Text Container
    private var iconContainer: some View {
        ZStack {
            Circle()
                .fill(iconBackgroundGradient)
                .frame(width: 56, height: 56)
                .shadow(color: gradientColors.first?.opacity(0.3) ?? .clear, radius: 6, x: 0, y: 3)
            
            Image(systemName: iconName)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(iconGradient)
        }
    }
    
    // Text Container
    private var textContent: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
            
            Text(subTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
        }
        
    }
    
    // Progress Indicator
    private var progressIndicator: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 3)
                .fill(progressGradient)
                .frame(height: 6)
                .frame(width: geometry.size.width * 0.7)
                .transition(.asymmetric(insertion: .scale(scale: 0.1, anchor: .leading).combined(with: .opacity), removal: .opacity))
        }
        .frame(height: 6)
    }
    
    // Badge Section
    private func badgeSection(_ text: String) -> some View{
        HStack{
            Spacer()
            
            if !text.isEmpty {
                Text(text)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(badgeGradient)
                    )
            }
        }
    }
    // Card background
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: 0,
                y: shadowOffset
            )
    }
    
    // Card Border
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(
                LinearGradient(
                    colors: gradientColors.map {$0.opacity(0.3)},
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: isHovered ? 2 : 1
            )
    }
    
    //
    private var iconBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors.map {$0.opacity(0.15)},
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var iconGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var progressGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private var badgeGradient: LinearGradient {
        LinearGradient(
            colors: gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    // Shadow properties
    private var shadowColor: Color {
        gradientColors.first?.opacity(isPressed ? 0.2 : 0.3) ?? .gray.opacity(0.3)
    }
    
    private var shadowRadius: CGFloat {
        isPressed ? 8 : 12
    }
    
    private var shadowOffset: CGFloat {
        isPressed ? 4 : 8
    }
    
    // Helper Methods
    private func handlePressState(_ pressing: Bool) {
        withAnimation(.easeInOut(duration: 0.1)) {
            isPressed = pressing
        }
    }
    
    private func hapticFeedBack() {
        NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
    }
    
    
    
}

#Preview {
    ProfessionalCardView(title: "Analytics", subTitle: "View detailed perfomance metrics and insights", iconName: "chart.line.uptrend.xyaxis", gradientColors: [.blue, .cyan  ], badgeText: "New") {
        
    }
}
