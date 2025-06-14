# ProfessionalCard

![Version](https://img.shields.io/badge/version-1.0.1-blue)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Compatible-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

**ProfessionalCard** is a SwiftUI component that displays a clean and elegant personal or business card. Easily customizable and perfect for apps that want to present contact or professional information in a stylish way.

## ✨ Features

- Modern business card design
- SwiftUI-native
- Fully customizable: name, title, contact info, colors
- Works on both iOS and macOS
- Lightweight and dependency-free

## 🛠 Installation

### 📦 Swift Package Manager (SPM)

You can add this package directly through **Xcode**:

1. Open your project in Xcode.
2. Go to **File > Add Packages...**
3. Enter the URL of the repository: https://github.com/Ivan-Bondaruk/ProfessionalCard
4. Select version `1.0.1` or **Up to Next Major**.
5. Click **Add Package**.

That's it! The package is now ready to use in your SwiftUI project.

## 💻 Requirements

- iOS 14.0+ / macOS 11.0+
- Xcode 13+
- Swift 5.5+
- SwiftUI framework

## 🧩 Usage

```swift
import ProfessionalCard

ProfessionalCardView(titile: "Analytics",
  subtitile: "View detailed perfomance metrics and insights",
  iconName: "chart.line.uptrend.xyaxis",
  gradientColors: [.blue, .cyan  ], badgeText: "New") {
  // Action Here
}
