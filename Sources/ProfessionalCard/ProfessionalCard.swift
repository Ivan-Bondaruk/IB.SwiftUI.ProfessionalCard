//
//  ProfessinalCard.swift
//
//  Created by Ivan Bondaruk on 14/06/2025.
//

import SwiftUI
import AppKit

public struct ProfessionalCardView: View {
    @StateObject var viewModel: ProfessionalCardViewViewModel
    
    /// Init
    ///
    /// - Parameters:
    ///   - title: Card title
    ///   - subTitle: Card sub title
    ///   - iconName: Card icon
    ///   - gradientColors: Which colors need to use to make gradient effect
    ///   - badgeText: Card badge text
    ///   - action: Action that needs to be execute when press on card
    public init(title: String,
                subTitle: String,
                iconName: String,
                gradientColors: [Color],
                badgeText: String?, action: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: ProfessionalCardViewViewModel(
            title: title,
            subTitle: subTitle,
            iconName: iconName,
            gradientColors: gradientColors,
            badgeText: badgeText,
            action: action
        ))
    }
    
    public var body: some View {
        Button {
            viewModel.action()
        } label: {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(viewModel.isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6,), value: viewModel.isPressed)
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity,
            pressing: viewModel.handlePressState,
            perform: {}
        )
        .onHover{ hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.isHovered = hovering
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(0.3)) {
                viewModel.showProgressBar = true
            }
        }
    }
    
    // Card Content
    private var cardContent: some View {
        VStack(spacing: 20) {
            headerSection
            
            if viewModel.showProgressBar {
                progressIndicator
            }
            
            if let badge = viewModel.badgeText {
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
                .fill(viewModel.iconBackgroundGradient)
                .frame(width: 56, height: 56)
                .shadow(color: viewModel.gradientColors.first?.opacity(0.3) ?? .clear, radius: 6, x: 0, y: 3)
            
            Image(systemName: viewModel.iconName)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.iconGradient)
        }
    }
    
    // Text Container
    private var textContent: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(viewModel.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.trailing)
            
            Text(viewModel.subTitle)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true) // ✅ Переносит по ширине
        }
        
    }
    
    // Progress Indicator
    private var progressIndicator: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 3)
                .fill(viewModel.progressGradient)
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
                            .fill(viewModel.badgeGradient)
                    )
            }
        }
    }
    // Card background
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .shadow(
                color: viewModel.shadowColor,
                radius: viewModel.shadowRadius,
                x: 0,
                y: viewModel.shadowOffset
            )
    }
    
    // Card Border
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(
                LinearGradient(
                    colors: viewModel.gradientColors.map {$0.opacity(0.3)},
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: viewModel.isHovered ? 2 : 1
            )
    }
}

#Preview {
    ProfessionalCardView(title: "Analytics", subTitle: "View detailed perfomance metrics and insights", iconName: "chart.line.uptrend.xyaxis", gradientColors: [.blue, .cyan  ], badgeText: "New") {
        
    }
}
